//
//  ListingService.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Combine

protocol ListingServiceProtocol {
    func getListings() -> AnyPublisher<ListingResponse, Error>
    func getListings() async throws -> ListingResponse
}

class ListingService: ListingServiceProtocol{
    @Injected(\.networkUtility) var networkUtility
    
    var cancellables = Set<AnyCancellable>()
    
    func getListings() -> AnyPublisher<ListingResponse, Error> {
        networkUtility.request(target: ListingAPITarget.getListing)
    }
    
    func getListings() async throws -> ListingResponse {
        try await withCheckedThrowingContinuation { continuation in
            networkUtility.request(target: ListingAPITarget.getListing)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }, receiveValue: { response in
                    continuation.resume(with: .success(response))
                })
                .store(in: &cancellables)
        }
        
    }
}
