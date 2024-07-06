//
//  ListingService.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Combine

protocol ListingServiceProtocol {
    func getListings() -> AnyPublisher<ListingResponse, Error>
}

class ListingService: ListingServiceProtocol{
    var networkUtility = NetworkUtility()
    
    func getListings() -> AnyPublisher<ListingResponse, Error> {
        networkUtility.request(target: ListingAPITarget.getListing)
    }
}
