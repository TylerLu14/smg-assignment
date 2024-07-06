//
//  Address.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation

struct Address: Decodable {
    struct Coordinate: Decodable {
        var latitude: Double
        var longitude: Double
    }
    
    var country: String
    var locality: String
    @DefaultEmptyString var region: String
    @DefaultEmptyString var street: String
    var postalCode: String
    var geoCoordinates: Coordinate?
}
