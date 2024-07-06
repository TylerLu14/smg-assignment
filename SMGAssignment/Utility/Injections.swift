//
//  Injections.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation

/// LoginRepo DI Key
private struct ListingServiceKey: InjectionKey {
    static var currentValue: ListingServiceProtocol = ListingService()
}

extension InjectedValues {
    var listingService: ListingServiceProtocol {
        get { Self[ListingServiceKey.self] }
        set { Self[ListingServiceKey.self] = newValue }
    }
}

/// LoginRepo DI Key
private struct NetworkUtilityKey: InjectionKey {
    static var currentValue: NetworkUtility = NetworkUtility()
}

extension InjectedValues {
    var networkUtility: NetworkUtility {
        get { Self[NetworkUtilityKey.self] }
        set { Self[NetworkUtilityKey.self] = newValue }
    }
}
