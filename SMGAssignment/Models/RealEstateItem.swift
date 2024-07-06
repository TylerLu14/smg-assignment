//
//  File.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation
import BetterCodable

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

struct Listing: Decodable {
    enum OffserType: String, Decodable{
        case buy = "BUY"
        case sell = "SELL"
    }
    
    enum Category: String, Decodable {
        case house = "HOUSE"
        case singleHouse = "SINGLE_HOUSE"
        case multipleDwelling = "MULTIPLE_DWELLING"
        case chalet = "CHALET"
        case castle = "CASTLE"
    }
    
    struct Price: Decodable {
        struct Buy: Decodable {
            @DefaultEmptyString var area: String
            @DefaultEmptyString var interval: String
            var price: Int
        }
        var currency: String
        var buy: Buy
    }
    
    struct Characteristic: Decodable {
        var numberOfRooms: Double
        var livingSpace: Int
        var lotSize: Int
        var totalFloorSpace: Int
    }
    
    struct Localization: Decodable {
        struct Attachment: Decodable {
            var type: String
            var url: String
            var file: String
        }
        struct LocalizableInfo: Decodable {
            struct Text: Decodable {
                var title: String
            }
            
            struct URL: Decodable {
                var type: String
            }
            
            @DefaultEmptyArray var attachments: [Attachment]
            var text: Text
            var urls: [URL]
        }
        var primary: String
        var de: LocalizableInfo
    }
    
    struct Lister: Decodable {
        @DefaultEmptyString var phone: String
        @DefaultEmptyString var logoUrl: String
    }
    
    var id: String
    var offerType: OffserType
    var categories: [Category]
    var prices: Price
    var address: Address
    var localization: Localization
    var lister: Lister
}

struct RealEstateItem: Decodable {
    struct ListerBrand: Decodable {
        var logoUrl: String
        var legalName: String
        @DefaultEmptyString var name: String
        var address: Address?
        var adActive: Bool
        var isQualityPartner: Bool
        var isPremiumBranding: Bool
        var profilePageUrlKeyword: String
    }
    
    var id: String
    var remoteViewing: Bool
    var listerBranding: ListerBrand?
    var listing: Listing
}

struct ListingResponse: Decodable {
    var from: Int
    var size: Int
    var total: Int
    var results: [RealEstateItem]
}


extension Listing.Localization.Attachment {
    var imgURL: URL? {
        URL(string: self.url)
    }
}

extension RealEstateItem: Identifiable {} 
