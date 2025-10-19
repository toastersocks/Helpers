//
//  Backports.swift
//  
//
//  Created by James Pamplona on 3/10/23.
//

import SwiftUI


public extension Backport where Content: View {
    @ViewBuilder func bold(_ isActive: Bool = true) -> some View {
        if #available(iOS 16, macOS 13, watchOS 9, *) {

            content.bold(isActive)
        } else {
            if isActive {
                content
                    .modifier(BoldViewModifier())
            } else {
                content
            }
        }
    }
}

public extension Backport where Content: View {
    @ViewBuilder
    @MainActor
    func fontWeight(_ weight: Font.Weight) -> some View {
        if #available(iOS 16, macOS 13, watchOS 9, *) {
            content.fontWeight(weight)
        } else {
            content.modifier(FontWeightModifier(weight))
        }
    }
}

@available(macOS 12, iOS 15, *)
public extension Backport where Content: View {
    @ViewBuilder func monospaced(_ isActive: Bool ) -> some View {
        if #available(iOS 16, macOS 13, watchOS 9, *) {
            content.monospaced(isActive)
        } else {
            if isActive, #available(watchOS 9, *) {
                content.modifier(MonospacedModifier())
            } else {
                content
            }
        }
    }
}

fileprivate struct BoldViewModifier: ViewModifier {
    @Environment(\.font) private var font

    func body(content: Content) -> some View {
        content
            .font(font?.weight(.bold))
    }
}

fileprivate struct FontWeightModifier: ViewModifier {
    @Environment(\.font) private var font
    private var weight: Font.Weight

    func body(content: Content) -> some View {
        content
            .font(font?.weight(weight))
    }

    init(_ weight: Font.Weight) {
        self.weight = weight
    }
}

@available(macOS 12, iOS 15, watchOS 9, *)
fileprivate struct MonospacedModifier: ViewModifier {
    @Environment(\.font) private var font

    func body(content: Content) -> some View {
        content
            .font(font?.monospaced())
    }
}

