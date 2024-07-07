//
//  File.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation
import BetterCodable

struct RealestateItem: Decodable {
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

extension RealestateItem: Identifiable {} 
