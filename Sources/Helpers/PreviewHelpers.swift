//
//  PreviewHelpers.swift
//  
//
//  Created by James Pamplona on 3/6/23.
//

#if DEBUG
import SwiftUI


public struct PreviewBindingHelper<A, Content: View>: View {
    @State private var value: A
    @ViewBuilder private var content: (Binding<A>) -> Content

    public var body: some View {
        content($value)
    }

    public init(value: A, @ViewBuilder content: @escaping (Binding<A>) -> Content) {
        _value = State(wrappedValue: value)
        self.content = content
    }
}

public struct PreviewBindingHelper2<A, B, Content: View>: View {
    @State private var values: (A, B)
    @ViewBuilder private var content: (Binding<A>, Binding<B>) -> Content

    public var body: some View {
        content($values.0.projectedValue, $values.1.projectedValue)
    }

    public init(values: (A, B), @ViewBuilder content: @escaping (Binding<A>, Binding<B>) -> Content) {
        _values = State(wrappedValue: values)
        self.content = content
    }
}

public struct PreviewBindingHelper3<A, B, C, Content: View>: View {
    @State private var values: (A, B, C)
    @ViewBuilder private var content: (Binding<A>, Binding<B>, Binding<C>) -> Content

    public var body: some View {
        content($values.0.projectedValue, $values.1.projectedValue, $values.2.projectedValue)
    }

    public init(values: (A, B, C), @ViewBuilder content: @escaping (Binding<A>, Binding<B>, Binding<C>) -> Content) {
        _values = State(wrappedValue: values)
        self.content = content
    }
}

public struct PreviewBindingHelper4<A, B, C, D, Content: View>: View {
    @State private var values: (A, B, C, D)
    @ViewBuilder private var content: (Binding<A>, Binding<B>, Binding<C>, Binding<D>) -> Content

    public var body: some View {
        content($values.0.projectedValue, $values.1.projectedValue, $values.2.projectedValue, $values.3.projectedValue)
    }

    public init(values: (A, B, C, D), @ViewBuilder content: @escaping (Binding<A>, Binding<B>, Binding<C>, Binding<D>) -> Content) {
        _values = State(wrappedValue: values)
        self.content = content
    }
}

public struct PreviewBindingHelper5<A, B, C, D, E, Content: View>: View {
    @State private var values: (A, B, C, D, E)
    @ViewBuilder private var content: (Binding<A>, Binding<B>, Binding<C>, Binding<D>, Binding<E>) -> Content

    public var body: some View {
        content($values.0.projectedValue, $values.1.projectedValue, $values.2.projectedValue, $values.3.projectedValue, $values.4.projectedValue)
    }

    public init(values: (A, B, C, D, E), @ViewBuilder content: @escaping (Binding<A>, Binding<B>, Binding<C>, Binding<D>, Binding<E>) -> Content) {
        _values = State(wrappedValue: values)
        self.content = content
    }
}

public struct PreviewBindingHelper6<A, B, C, D, E, F, Content: View>: View {
    @State private var values: (A, B, C, D, E, F)
    @ViewBuilder private var content: (Binding<A>, Binding<B>, Binding<C>, Binding<D>, Binding<E>, Binding<F>) -> Content

    public var body: some View {
        content($values.0.projectedValue, $values.1.projectedValue, $values.2.projectedValue, $values.3.projectedValue, $values.4.projectedValue, $values.5.projectedValue)
    }

    public init(values: (A, B, C, D, E, F), @ViewBuilder content: @escaping (Binding<A>, Binding<B>, Binding<C>, Binding<D>, Binding<E>, Binding<F>) -> Content) {
        _values = State(wrappedValue: values)
        self.content = content
    }
}

public struct PreviewBindingHelper7<A, B, C, D, E, F, G, Content: View>: View {
    @State private var values: (A, B, C, D, E, F, G)
    @ViewBuilder private var content: (Binding<A>, Binding<B>, Binding<C>, Binding<D>, Binding<E>, Binding<F>, Binding<G>) -> Content

    public var body: some View {
        content($values.0.projectedValue, $values.1.projectedValue, $values.2.projectedValue, $values.3.projectedValue, $values.4.projectedValue, $values.5.projectedValue, $values.6.projectedValue)
    }

    public init(values: (A, B, C, D, E, F, G), @ViewBuilder content: @escaping (Binding<A>, Binding<B>, Binding<C>, Binding<D>, Binding<E>, Binding<F>, Binding<G>) -> Content) {
        _values = State(wrappedValue: values)
        self.content = content
    }
}


#endif
