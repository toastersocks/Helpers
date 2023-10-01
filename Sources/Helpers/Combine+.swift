//
//  Combine+.swift
//  TimeKeeper
//
//  Created by James Pamplona on 8/27/22.
//

import Combine


extension Publishers {
    static func CombineLatest5<A: Publisher, B: Publisher, C: Publisher, D: Publisher, E: Publisher>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) -> AnyPublisher<(A.Output, B.Output, C.Output, D.Output, E.Output), A.Failure> where A.Failure == B.Failure, B.Failure == C.Failure, C.Failure == D.Failure, D.Failure == E.Failure {
        a.combineLatest(b, c, d, e)
    }

    static func CombineLatest6<A: Publisher, B: Publisher, C: Publisher, D: Publisher, E: Publisher, F: Publisher>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F) -> AnyPublisher<(A.Output, B.Output, C.Output, D.Output, E.Output, F.Output), A.Failure> where A.Failure == B.Failure, B.Failure == C.Failure, C.Failure == D.Failure, D.Failure == E.Failure, E.Failure == F.Failure {
        a.combineLatest(b, c, d, e, f)
    }

    static func CombineLatest7<A: Publisher, B: Publisher, C: Publisher, D: Publisher, E: Publisher, F: Publisher, G: Publisher>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G) -> AnyPublisher<(A.Output, B.Output, C.Output, D.Output, E.Output, F.Output, G.Output), A.Failure> where A.Failure == B.Failure, B.Failure == C.Failure, C.Failure == D.Failure, D.Failure == E.Failure, E.Failure == F.Failure, F.Failure == G.Failure {
        a.combineLatest(b, c, d, e, f, g)
    }

    static func CombineLatest8<A: Publisher, B: Publisher, C: Publisher, D: Publisher, E: Publisher, F: Publisher, G: Publisher, H: Publisher>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H) -> AnyPublisher<(A.Output, B.Output, C.Output, D.Output, E.Output, F.Output, G.Output, H.Output), A.Failure> where A.Failure == B.Failure, B.Failure == C.Failure, C.Failure == D.Failure, D.Failure == E.Failure, E.Failure == F.Failure, F.Failure == G.Failure, G.Failure == H.Failure {
        a.combineLatest(b, c, d, e, f, g, h)
    }

    /* Awaiting this PR: https://github.com/apple/swift/pull/67465
    static func MyCombineLatest<A: Publisher, each P: Publisher>(_ a: A, _ p: repeat each P) where repeat A.Failure == (each P).Failure {
        repeat a.combineLatest(each p)
    }
    */
}

extension Publisher {
    func combineLatest<B: Publisher, C: Publisher, D: Publisher, E: Publisher>(_ b: B, _ c: C, _ d: D, _ e: E) -> AnyPublisher<(Output, B.Output, C.Output, D.Output, E.Output), Failure>
    where Self.Failure == B.Failure, B.Failure == C.Failure, C.Failure == D.Failure, D.Failure == E.Failure {
        Publishers.CombineLatest(
            Publishers.CombineLatest3(self, b, c),
            Publishers.CombineLatest(d, e)
        ).map { set1, set2 -> (Output, B.Output, C.Output, D.Output, E.Output) in
            let (a, b, c) = set1
            let (d, e) = set2

            return (a, b, c, d, e)
        }.eraseToAnyPublisher()
    }

    func combineLatest<B: Publisher, C: Publisher, D: Publisher, E: Publisher, F: Publisher>(_ b: B, _ c: C, _ d: D, _ e: E, _ f: F) -> AnyPublisher<(Output, B.Output, C.Output, D.Output, E.Output, F.Output), Failure>
    where Self.Failure == B.Failure, B.Failure == C.Failure, C.Failure == D.Failure, D.Failure == E.Failure, E.Failure == F.Failure {
        Publishers.CombineLatest(
            Publishers.CombineLatest3(self, b, c),
            Publishers.CombineLatest3(d, e, f)
        ).map { set1, set2 -> (Output, B.Output, C.Output, D.Output, E.Output, F.Output) in
            let (a, b, c) = set1
            let (d, e, f) = set2

            return (a, b, c, d, e, f)
        }.eraseToAnyPublisher()
    }

    func combineLatest<B: Publisher, C: Publisher, D: Publisher, E: Publisher, F: Publisher, G: Publisher>(_ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G) -> AnyPublisher<(Output, B.Output, C.Output, D.Output, E.Output, F.Output, G.Output), Failure>
    where Self.Failure == B.Failure, B.Failure == C.Failure, C.Failure == D.Failure, D.Failure == E.Failure, E.Failure == F.Failure, F.Failure == G.Failure {
        Publishers.CombineLatest(
            Publishers.CombineLatest4(self, b, c, d),
            Publishers.CombineLatest3(e, f, g)
        ).map { set1, set2 -> (Output, B.Output, C.Output, D.Output, E.Output, F.Output, G.Output) in
            let (a, b, c, d) = set1
            let (e, f, g) = set2

            return (a, b, c, d, e, f, g)
        }.eraseToAnyPublisher()
    }

    func combineLatest<B: Publisher, C: Publisher, D: Publisher, E: Publisher, F: Publisher, G: Publisher, H: Publisher>
    (_ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H) -> AnyPublisher<(Output, B.Output, C.Output, D.Output, E.Output, F.Output, G.Output, H.Output), Failure>
    where Self.Failure == B.Failure, B.Failure == C.Failure, C.Failure == D.Failure, D.Failure == E.Failure, E.Failure == F.Failure, F.Failure == G.Failure, G.Failure == H.Failure {
        Publishers.CombineLatest(
            Publishers.CombineLatest4(self, b, c, d),
            Publishers.CombineLatest4(e, f, g, h)
        ).map { set1, set2 -> (Output, B.Output, C.Output, D.Output, E.Output, F.Output, G.Output, H.Output) in
            let (a, b, c, d) = set1
            let (e, f, g, h) = set2

            return (a, b, c, d, e, f, g, h)
        }.eraseToAnyPublisher()
    }

    /* Awaiting this PR: https://github.com/apple/swift/pull/67465
    func combineLatest<each PublisherType: Publisher>(_ publishers: repeat each PublisherType) -> AnyPublisher<(Output, repeat (each PublisherType).Output), Failure> where repeat  Failure == (each PublisherType).Failure {

    }
    */
}
