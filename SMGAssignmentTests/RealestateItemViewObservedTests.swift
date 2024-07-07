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

final class RealestateItemViewObservedTests: XCTestCase {
    var mockItems: [RealestateItem] = []
    var favoritePersistent = Persistent<[String:Bool]>(key: "favoriteItems", defaultValue: [:])

    override func setUpWithError() throws {
        let response: ListingResponse = try JsonFileReader.shared.loadObject(fileName: "mock_properties")
        mockItems = response.results
        favoritePersistent.value = [:]
    }

    /// - When the load method is instantiated
    /// - Then the Observed default state is idle
    func testIdleState() {
        let sut = RealestateItemView.Observed(item: mockItems[0], isFavorite: false)
        XCTAssertEqual(sut.state, .idle)
    }
    
    /// - When the load method is invoked
    /// - Then the Observed state is loaded with data
    func testLoadingState() async throws {
        let sut = RealestateItemView.Observed(item: mockItems[0], isFavorite: false)
        sut.load()
        // Make sure the loading function not invoked too fast and giving false positive
        try await Task.sleep(nanoseconds: 1000_000_000)
        switch sut.state {
        case .loaded(let item):
            XCTAssertEqual(item.id, "3001118202")
            XCTAssertEqual(item.listing.offerType, .buy)
            XCTAssertTrue(item.listing.categories.contains(.house))
            XCTAssertTrue(item.listing.categories.contains(.chalet))
            XCTAssertEqual(item.listing.prices.currency, "CHF")
            XCTAssertEqual(item.listing.prices.buy.price, 9999999)
            
            XCTAssertEqual(item.listing.address.country, "CH")
            XCTAssertEqual(item.listing.address.locality, "La Brévine")
            XCTAssertEqual(item.listing.address.postalCode, "2406")
            XCTAssertEqual(item.listing.address.region, "NE")
            XCTAssertEqual(item.listing.address.street, "Musterstrasse 999")
            XCTAssertEqual(item.listing.address.geoCoordinates?.latitude, 46.980351942307)
            XCTAssertEqual(item.listing.address.geoCoordinates?.longitude, 6.606871481365)
            
            XCTAssertEqual(item.listing.localization.de.attachments.first?.type, .image)
            XCTAssertEqual(
                item.listing.localization.de.attachments.first?.url,
                "https://media2.homegate.ch/listings/hgonif/3001118202/image/98d48ffb80f47e03e03de3cbcf6e7f14.jpg"
            )
            XCTAssertEqual(item.listing.localization.de.attachments.first?.file, "a197c04ddc.jpg")
            
        default:
            XCTFail("RealestateItemView never falls to loading state. Data got loaded right away after calling load")
        }
    }
    
    /// - When the refresh method is invoked
    /// - Given the favorite list is empty
    /// - Then the Observed state is loaded with the response
    func testToggleFavorite() async throws {
        let item = mockItems[0]
        let sut = RealestateItemView.Observed(item: item, isFavorite: favoritePersistent.value[item.id] ?? false)
        sut.load()
        
        sut.toggleFavorite()
        XCTAssertTrue(favoritePersistent.value[item.id] ?? false)
        
        sut.toggleFavorite()
        XCTAssertFalse(favoritePersistent.value[item.id] ?? false)
    }
    
}

