//
//  Extensions.swift
//  
//
//  Created by James Pamplona on 3/13/23.
//

import SwiftUI


extension Binding {
    public func replacingNil<T>(with defaultValue: T) -> Binding<T> where Value == T? {
        Binding<T> {
            wrappedValue ?? defaultValue
        } set: { newValue in
            wrappedValue = newValue
        }
    }
}
