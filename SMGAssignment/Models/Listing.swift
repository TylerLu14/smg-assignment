//
//  Listing.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation
import BetterCodable

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
            enum `Type`: String, Decodable {
                case image = "IMAGE"
                case document = "DOCUMENT"
            }
            var type: `Type`
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

extension Listing.Localization.LocalizableInfo {
    var images: [Listing.Localization.Attachment] {
        self.attachments.filter { $0.type == .image }
    }
}

extension Listing.Localization.Attachment {
    var urlObject: URL? {
        URL(string: self.url)
    }
}
