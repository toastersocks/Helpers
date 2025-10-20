//
//  Variadic.swift
//  
//
//  Created by James Pamplona on 3/3/23.
//

import SwiftUI


public typealias VariadicView = _VariadicView

struct VariadicMultiRootAdapter<Adapted: View>: VariadicView.MultiViewRoot {
    var content: (VariadicView.Children) -> Adapted

    func body(children: VariadicView.Children) -> some View {
        content(children)
    }
}

struct VariadicUnaryRootAdapter<Adapted: View>: VariadicView.UnaryViewRoot {
    var content: (VariadicView.Children) -> Adapted

    func body(children: VariadicView.Children) -> some View {
        content(children)
    }
}

public extension View {
    func childViews<ChildList: View>(@ViewBuilder children: @escaping (VariadicView.Children) -> ChildList) -> some View {
        VariadicView.Tree(VariadicMultiRootAdapter(content: children), content: { self })
    }
    func unaryViews<ChildList: View>(@ViewBuilder children: @escaping (VariadicView.Children) -> ChildList) -> some View {
        VariadicView.Tree(VariadicUnaryRootAdapter(content: children), content: { self })
    }
}

@available(iOS, introduced: 13, obsoleted: 18)
@available(macOS, introduced: 11, obsoleted: 15)
@available(tvOS, introduced: 13, obsoleted: 18)
@available(watchOS, introduced: 8, obsoleted: 11)
@available(visionOS, introduced: 1, obsoleted: 2)
public extension Backport where Content == Never {
    @MainActor
    struct SubviewsCollection: RandomAccessCollection {
        private enum Storage: @unchecked Sendable {
            case legacy(VariadicView.Children)
            case native(Any)
        }

        private let storage: Storage

        nonisolated public var startIndex: Int { 0 }
        nonisolated public var endIndex: Int {
            switch storage {
            case .legacy(let children):
                children.count
            case .native(let subviews):
                if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
                    (subviews as! SwiftUI.SubviewsCollection).count
                } else {
                    0
                }
            }
        }

        nonisolated public subscript(position: Int) -> Subview {
            switch storage {
            case .legacy(let children):
                Subview(child: children[position])
            case .native(let subviews):
                if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
                    Subview(nativeSubview: (subviews as! SwiftUI.SubviewsCollection)[position])
                } else {
                    fatalError()
                }
            }
        }

        nonisolated fileprivate init(children: VariadicView.Children) {
            self.storage = .legacy(children)
        }

        @available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
        nonisolated fileprivate init(nativeSubviews: SwiftUI.SubviewsCollection) {
            self.storage = .native(nativeSubviews)
        }
    }

    @MainActor
    struct Subview: Identifiable, View {
        private enum Storage: @unchecked Sendable {
            case legacy(VariadicView.Children.Element)
            case native(Any)
        }

        private let storage: Storage

        nonisolated public var id: AnyHashable {
            switch storage {
            case .legacy(let child):
                child.id
            case .native(let subview):
                if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
                    (subview as! SwiftUI.Subview).id
                } else {
                    fatalError()
                }
            }
        }

        public var body: some View {
            switch storage {
            case .legacy(let child):
                child
            case .native(let subview):
                if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
                    subview as! SwiftUI.Subview
                } else {
                    EmptyView()
                }
            }
        }

        nonisolated fileprivate init(child: VariadicView.Children.Element) {
            self.storage = .legacy(child)
        }

        @available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
        nonisolated fileprivate init(nativeSubview: SwiftUI.Subview) {
            self.storage = .native(nativeSubview)
        }

        nonisolated public subscript<T>(key: T.Type) -> T.Value where T: _ViewTraitKey {
            switch storage {
            case .legacy(let child):
                child[key]
            case .native:
                fatalError("Use containerValues on iOS 18+")
            }
        }

        @available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
        nonisolated public var containerValues: ContainerValues {
            if case .native(let subview) = storage {
                return (subview as! SwiftUI.Subview).containerValues
            }
            fatalError("containerValues only available on iOS 18+")
        }
    }

    @MainActor
    struct Group<C: View, Result: View>: View {
        private let content: C
        private let transform: (SubviewsCollection) -> Result

        public var body: some View {
            if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
                SwiftUI.Group(subviews: content) { nativeSubviews in
                    transform(SubviewsCollection(nativeSubviews: nativeSubviews))
                }
            } else {
                content.childViews { children in
                    transform(SubviewsCollection(children: children))
                }
            }
        }

        public init(subviews content: C, @ViewBuilder transform: @escaping (SubviewsCollection) -> Result) {
            self.content = content
            self.transform = transform
        }
    }

    @MainActor
    struct ForEach<C: View, ElementContent: View>: View {
        private let content: C
        private let elementContent: (Subview) -> ElementContent

        public var body: some View {
            if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
                SwiftUI.ForEach(subviews: content) { nativeSubview in
                    elementContent(Subview(nativeSubview: nativeSubview))
                }
            } else {
                content.childViews { children in
                    SwiftUI.ForEach(SubviewsCollection(children: children), content: elementContent)
                }
            }
        }

        public init(subviews content: C, @ViewBuilder content elementContent: @escaping (Subview) -> ElementContent) {
            self.content = content
            self.elementContent = elementContent
        }
    }
}
