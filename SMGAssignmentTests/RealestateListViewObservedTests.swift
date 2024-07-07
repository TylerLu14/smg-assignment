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
    var favoritePersistent = Persistent<[String:Bool]>(key: "favoriteItems", defaultValue: [:])

    override func setUpWithError() throws {
        InjectedValues[\.listingService] = mockService
        favoritePersistent.value = [:]
    }

    /// - When the load method is instantiated
    /// - Then the Observed default state is idle
    func testIdleState() {
        let sut = RealestateListView.Observed()
        XCTAssertEqual(sut.state, .idle)
    }
    
    /// - When the load method is invoked
    /// - Given the service never returns any response
    /// - Then the Observed state is loading
    func testLoadingState() async throws {
        givenSwift(mockService.getListings())
            .willReturn(
                Empty()
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            )
        
        let sut = RealestateListView.Observed()
        sut.load()
        // Make sure the loading function not invoked too fast and giving false positive
        try await Task.sleep(nanoseconds: 1000_000_000)
        
        
        XCTAssertEqual(sut.state, .loading)
    }

    /// - When the load method is invoked
    /// - Given the service returns a response
    /// - Then the Observed state is failed with the response
    func testLoad_Success() throws {
        givenSwift(mockService.getListings())
            .willReturn(
                Just(try JsonFileReader.shared.loadObject(fileName: "mock_properties"))
                    .delay(for: 0.5, scheduler: RunLoop.main)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            )
        
        let sut = RealestateListView.Observed()
        
        let expectation = expectation(description: #function)
        withObservationTracking {
            sut.load()
            _ = sut.state
        } onChange: {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
        
        verify(mockService.getListings()).wasCalled(1)
        
        switch sut.state {
        case .loaded(let value):
            XCTAssertEqual(value.count, 8)
        default:
            XCTFail("Expected Loaded State")
        }
    }
    
    /// - When the load method is invoked
    /// - Given the service returns an error when calling getListings
    /// - Then the Observed state is failed with the given error
    func testLoad_Error() throws {
        givenSwift(mockService.getListings())
            .willReturn(
                Fail(error: URLError(.badURL))
                    .delay(for: 0.5, scheduler: RunLoop.main)
                    .eraseToAnyPublisher()
            )
        
        let sut = RealestateListView.Observed()
        let expectation = expectation(description: #function)
        
        withObservationTracking {
            sut.load()
            _ = sut.state
        } onChange: {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
        
        verify(mockService.getListings()).wasCalled(1)
        
        switch sut.state {
        case .failed(let error):
            XCTAssertTrue(error is URLError)
        default:
            XCTFail("Expected Loaded State")
        }
    }
    
    /// - When the refresh method is invoked
    /// - Given the service returns a response
    /// - Then the Observed state is loaded with the response
    func testRefresh_Success() async throws {
        givenSwift(await mockService.getListings())
            .willReturn(
                try JsonFileReader.shared.loadObject(fileName: "mock_properties")
            )
        
        let sut = RealestateListView.Observed()
        
        await sut.refresh()
        
        switch sut.state {
        case .loaded(let value):
            XCTAssertEqual(value.count, 8)
        default:
            XCTFail("Expected Loaded State")
        }
    }
    
    /// - When the refresh method is invoked
    /// - Given the service returns an error when calling getListings and the current state is loaded
    /// - Then the Observed state is failed with the given error
    func testRefresh_Error() async throws {
        givenSwift(await mockService.getListings())
            .will {
                throw URLError(.badURL)
            }
        
        let sut = RealestateListView.Observed()
        sut.state = .loaded([])
        
        await sut.refresh()
        
        verify(await mockService.getListings()).wasCalled(1)
        
        switch sut.state {
        case .failed(let error):
            XCTAssertTrue(error is URLError)
        default:
            XCTFail("Expected Loaded State")
        }
    }
    
    
    /// - When the toggleFavorite method is invoked
    /// - Given the service returns an error when calling getListings and the current state is loaded
    /// - Then the Observed state is failed with the given error
    func testToggleFavorite() async throws {
        givenSwift(mockService.getListings())
            .willReturn(
                Just(try JsonFileReader.shared.loadObject(fileName: "mock_properties"))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            )
        
        let sut = RealestateListView.Observed()
        sut.load()
        
        try await Task.sleep(nanoseconds: 500_000_000)
        
        sut.toggleFavorite()
        XCTAssertTrue(sut.isShowFavorite)
        
        switch sut.state {
        case .loaded(let observeds):
            XCTAssertEqual(observeds.count, 0)
        default:
            XCTFail("Expected Loaded State")
        }
        
        sut.toggleFavorite()
        XCTAssertFalse(sut.isShowFavorite)
        switch sut.state {
        case .loaded(let observeds):
            XCTAssertEqual(observeds.count, 8)
        default:
            XCTFail("Expected Loaded State")
        }
        
        // Given 2 items are added to favorite list
        favoritePersistent.value["3001697853"] = true
        favoritePersistent.value["3002090762"] = true
        
        sut.toggleFavorite()
        
        try await Task.sleep(nanoseconds: 1_500_000_000)
        
        XCTAssertTrue(sut.isShowFavorite)
        switch sut.state {
        case .loaded(let observeds):
            XCTAssertEqual(observeds.count, 2)
        default:
            XCTFail("Expected Loaded State")
        }
    }
}

