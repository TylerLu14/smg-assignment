//
//  ListingAPITarget.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation

struct ListRequestParameter: Encodable {
    
}

/// Enum of card API
enum ListingAPITarget: APITargetProtocol {
    case getListing
    
    var method: APIMethod {
        .GET
    }
    
    var headers: [String : String] {
        defaultHeaders
    }
    
    var parameters: Encodable {
        switch self {
        case .getListing: return ListRequestParameter()
        }
    }
    
    var host: String {
        "https://private-9f1bb1-homegate3.apiary-mock.com"
    }

    var path: String {
        switch self {
        case .getListing: return "properties"
        }
    }
    
    var urlString: String {
        "\(host)/\(path)"
    }
}
