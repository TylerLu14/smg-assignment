//
//  APITarget.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation

/// HTTP methods enums
enum APIMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

/// HTTP request protocol
protocol APITargetProtocol {
    var method: APIMethod { get }
    var urlString: String { get }
    var headers: [String: String] { get }
    var parameters: Encodable { get }
}

extension APITargetProtocol {
    /// Create a custom request header
    var defaultHeaders: [String: String] { [:] }

    func getBody() throws -> Data {
        try JSONEncoder().encode(parameters)
    }
    
    func getURLRequest() throws -> URLRequest {
        guard let url: URL = URL(string: self.urlString) else {
            throw URLError(.badURL)
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if method != .GET {
            request.httpBody = try getBody()
        }
        request.allHTTPHeaderFields = headers
        return request
    }
}
