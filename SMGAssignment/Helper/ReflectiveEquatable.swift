//
//  ReflectiveEquatable.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation

// Helper to compare property with enum
protocol ReflectiveEquatable: Equatable {}

extension ReflectiveEquatable {

    var reflectedValue: String { String(reflecting: self) }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.reflectedValue == rhs.reflectedValue
    }
}
