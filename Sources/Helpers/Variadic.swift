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
