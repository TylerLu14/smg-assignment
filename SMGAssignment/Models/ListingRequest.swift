//
//  ListingResponse.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation

struct ListRequestParameter: Encodable {
    
}

struct ListingResponse: Decodable {
    var from: Int
    var size: Int
    var total: Int
    var results: [RealestateItem]
}
