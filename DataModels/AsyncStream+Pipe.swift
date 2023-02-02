//
//  AsyncStream+Pipe.swift
//  SOPS001X
//
//  Created by Sedat Onat on 2.02.2023.
//

import Foundation

extension AsyncStream {
    static func pipe() -> ((Element) -> Void, Self) {
        var input: (Element) -> Void = { _ in }
        let output = Self { continuation in
            input = { element in
                continuation.yield(element)
            }
        }
        return (input, output)
    }
}
