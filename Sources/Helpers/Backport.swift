//
//  Backport.swift
//  
//
//  Created by James Pamplona on 3/10/23.
//

import SwiftUI


public struct Backport<Content> {
    public let content: Content

    public init(_ content: Content) {
        self.content = content
    }
}

public extension View {
    var backport: Backport<Self> { Backport(self) }
}


