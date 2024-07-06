//
//  BetterCodableExtension.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import BetterCodable

// MARK: - DefaultEmptyString
struct DefaultEmptyStringStrategy: DefaultCodableStrategy {
    static var defaultValue: String { "" }
}

typealias DefaultEmptyString = DefaultCodable<DefaultEmptyStringStrategy>
