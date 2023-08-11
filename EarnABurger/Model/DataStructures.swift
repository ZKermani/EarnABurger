//
//  DataStructures.swift
//  EarnABurger
//
//  Created by Zahra Kermani on 11.08.23.
//

import Foundation

struct ActivitySummary: Loopable {
    var date: String
    var distance: String
    var duration: String
    var avgPace: String
}


protocol Loopable {
    func allProperties() throws -> [String: Any]
}

extension Loopable {
    func allProperties() throws -> [String: Any] {

        var result: [String: Any] = [:]

        let mirror = Mirror(reflecting: self)

        // Optional check to make sure we're iterating over a struct or class
        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            throw NSError()
        }

        for (property, value) in mirror.children {
            guard let property = property else {
                continue
            }

            result[property] = value
        }

        return result
    }
}
