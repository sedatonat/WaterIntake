// Copied from IOS Example ToDo App

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
