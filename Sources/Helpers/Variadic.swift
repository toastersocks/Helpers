//
//  Variadic.swift
//  
//
//  Created by James Pamplona on 3/3/23.
//

import SwiftUI


struct VariadicMultiRootAdapter<Adapted: View>: _VariadicView_MultiViewRoot {
    var content: (_VariadicView.Children) -> Adapted

    func body(children: _VariadicView.Children) -> some View {
        content(children)
    }
}

struct VariadicUnaryRootAdapter<Adapted: View>: _VariadicView_UnaryViewRoot {
    var content: (_VariadicView.Children) -> Adapted

    func body(children: _VariadicView.Children) -> some View {
        content(children)
    }
}

public extension View {
    func childViews<ChildList: View>(@ViewBuilder children: @escaping (_VariadicView.Children) -> ChildList) -> some View {
        _VariadicView.Tree(VariadicMultiRootAdapter(content: children), content: { self })
    }
    func unaryViews<ChildList: View>(@ViewBuilder children: @escaping (_VariadicView.Children) -> ChildList) -> some View {
        _VariadicView.Tree(VariadicUnaryRootAdapter(content: children), content: { self })
    }
}
