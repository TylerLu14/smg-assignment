//
//  RealestateListViewObservedTests.swift
//  SMGAssignmentTests
//
//  Created by Lữ on 7/7/24.
//

import XCTest
import Mockingbird
import Combine
@testable import SMGAssignment

final class RealestateListViewObservedTests: XCTestCase {
    let mockService = mock(ListingServiceProtocol.self)

    func setUp(completion: @escaping ((any Error)?) -> Void)
 async throws {
        InjectedValues[\.listingService] = mockService
        
        givenSwift(
            mockService.getListings()
        )
        .willReturn(
            Just(try JsonFileReader.shared.loadObject(fileName: "mock_properties"))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        )
        
        givenSwift(
            await mockService.getListings()
        )
        .willReturn(
            try JsonFileReader.shared.loadObject(fileName: "mock_properties")
        )
        
    }

    func testExample() throws {
        
    }

    

}

