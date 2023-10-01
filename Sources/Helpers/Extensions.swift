//
//  Extensions.swift
//  
//
//  Created by James Pamplona on 3/13/23.
//

import SwiftUI


@available(iOS 15, macOS 12, *)
public extension Color {
    static var rainbow: Rainbow.Type {
        Rainbow.self
    }

    enum Rainbow {
        static var red: Color     = .red
        static var orange: Color  = .orange
        static var yellow: Color  = .yellow
        static var green: Color   = .green
        static var blue: Color    = .blue
        static var indigo: Color  = .indigo
        static var violet: Color  = .purple

        static var allColors: [Color] = [
            .red,
            .orange,
            .yellow,
            .green,
            .blue,
            .indigo,
            .purple,
        ]
        public static func random() -> Color {
            allColors.randomElement()!
        }
    }
}

extension Binding {
    public func replacingNil<T>(with defaultValue: T) -> Binding<T> where Value == T? {
        Binding<T> {
            wrappedValue ?? defaultValue
        } set: { newValue in
            wrappedValue = newValue
        }
    }
}
