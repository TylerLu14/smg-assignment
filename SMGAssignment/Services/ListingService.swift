//
//  ListingService.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Combine


enum ListingAPITarget: APITargetProtocol {
    case getListing
    
    var method: APIMethod { .GET }
    var headers: [String : String] { defaultHeaders }
    var host: String { "https://private-9f1bb1-homegate3.apiary-mock.com" }

    var path: String {
        switch self {
        case .getListing: return "properties"
        }
    }
    
    var urlString: String {
        "\(host)/\(path)"
    }
    
    var parameters: Encodable {
        switch self {
        case .getListing: return ListRequestParameter()
        }
    }
}

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
            getListings()
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
