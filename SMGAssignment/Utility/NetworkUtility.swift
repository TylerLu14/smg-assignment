//
//  NetworkUtility.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation
import Combine

class NetworkUtility {
    struct Constants {
        /// Tag to use for the logger
        fileprivate static let TAG: String = "NetworkUtility"
    }
    
    var urlSession: URLSession
    
    init() {
        let configuration: URLSessionConfiguration = .default
        configuration.timeoutIntervalForRequest  = 10
        configuration.timeoutIntervalForResource = 10

        URLCache.shared.diskCapacity = 1024 * 1024 * 1024
        URLCache.shared.memoryCapacity = 200 * 1024 * 1024

        configuration.urlCache = URLCache.shared

        urlSession = URLSession(
            configuration: configuration,
            delegate: nil,
            delegateQueue: nil
        )
    }
    
    func request<T: Decodable>(target: any APITargetProtocol) -> AnyPublisher<T, Error> {
        requestData(target: target)
            .tryMap(decodeResponse)
            .handleEvents(receiveCompletion: logError)
            .eraseToAnyPublisher()
    }

    /// fetchApi
    /// makes a network call and parse the response to binary Data.
    /// makes the network call from URLSession
    /// Log the request and response
    /// Parameters:
    ///  - target: APITargetProtocol - contains the host, header, request body of the request
    ///  - needCheckLocalBiometric: Bool - ?
    private func requestData(target: any APITargetProtocol) -> AnyPublisher<Data, Error> {
        AnyPublisher { subscriber in
            do {
                let request = try target.getURLRequest()
                subscriber.send(request)
            } catch {
                subscriber.send(completion: .failure(error))
            }
            subscriber.send(completion: .finished)
            return AnyCancellable { }
        }
        .handleEvents(receiveOutput: logRequest)
        .flatMap { [unowned self] urlRequest in
            urlSession.dataTaskPublisher(for: urlRequest)
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
        }
        .handleEvents(receiveOutput: logResponse)
        .map { data, response in data }
        .eraseToAnyPublisher()
    }
    /// Decode the response data
    ///  - Parameters:
    ///   - data: The JSON Data response
    private func decodeResponse<T: Decodable>(data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
    
    /// Log the URL Request
    private func logRequest(request: URLRequest) {
        // Log the request
        Logger.i("\(type(of: self))", "Request Header:\n\(request.allHTTPHeaderFields as AnyObject)")

        if let url = request.url {
            if let httpBody = request.httpBody, let body = String(data: httpBody, encoding: .utf8) {
                Logger.i("\(type(of: self))", "Request(\(url.absoluteString): \(body).\n")
            } else {
                Logger.i("\(type(of: self))", "Request(\(url.absoluteString): [-(nil)-].\n")
            }
        }
    }
    /// Log the Response data in UTF8
    private func logResponse(data: Data, response: URLResponse) {
        if let url = response.url {
            let jsonString = String(data: data, encoding: .utf8)
            Logger.i(Constants.TAG, "Response(\(url.absoluteString): \(jsonString ?? "[-(nil)-]").\n")
        }
    }

    /// Log The URL Request Error
    private func logError(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            Logger.i("\(type(of: self))", "Finished")
        case .failure(let error):
            Logger.e("\(type(of: self))", error.localizedDescription)
        }
    }
}
