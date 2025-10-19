//
//  Extensions.swift
//  
//
//  Created by James Pamplona on 3/13/23.
//

import SwiftUI


@available(iOS 15, macOS 12, watchOS 8, *)
public extension Color {
    static var rainbow: Rainbow.Type {
        Rainbow.self
    }

    enum Rainbow {
        static let red: Color     = .red
        static let orange: Color  = .orange
        static let yellow: Color  = .yellow
        static let green: Color   = .green
        static let blue: Color    = .blue
        static let indigo: Color  = .indigo
        static let violet: Color  = .purple

        static let allColors: [Color] = [
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
    public func replacingNil<T: Sendable>(with defaultValue: T) -> Binding<T> where Value == T? {
        Binding<T> {
            wrappedValue ?? defaultValue
        } set: { newValue in
            wrappedValue = newValue
        }
    }
}
