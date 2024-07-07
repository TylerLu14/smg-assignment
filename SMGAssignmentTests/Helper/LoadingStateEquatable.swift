//
//  LoadingStateEquatable.swift
//  SMGAssignmentTests
//
//  Created by Lữ on 7/7/24.
//

import Foundation
@testable import SMGAssignment

// Help to compare property with enum
protocol ReflectiveEquatable: Equatable {}

extension ReflectiveEquatable {

    var reflectedValue: String { String(reflecting: self) }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.reflectedValue == rhs.reflectedValue
    }
}

extension LoadingState: ReflectiveEquatable { }
