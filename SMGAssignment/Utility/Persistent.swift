//
//  Persistent.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation

/// Persistent objects that get or store value from UserDefaults.standard
class Persistent<T> {
    private let userDefaults = UserDefaults.standard
    private let key: String
    private let defaultValue: T

    var value: T {
        get {
            (userDefaults.value(forKey: key) as? T) ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }
    /// Initalize a Persistent Object. the value is retrieved from UserDefaults.
    /// If the key doesn't exist yet, the value is set to default value and the default value is stored in
    /// UserDefaults
    /// - Parameters:
    ///     - key: unique key to identifies the object in UserDefaults
    ///     - defaultValue: the initial value
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
        if let value = userDefaults.object(forKey: key) as? T {
            self.value = value
        } else {
            self.value = defaultValue
        }
    }

    func removeObject() {
        userDefaults.removeObject(forKey: key)
    }
}
