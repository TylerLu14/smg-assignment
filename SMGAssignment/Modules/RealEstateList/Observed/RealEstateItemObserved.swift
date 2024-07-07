//
//  RealEstateItemObserved.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import SwiftUI
import Combine

extension RealEstateItemView {
    @Observable class Observed: BaseObserved<RealEstateItem> {
        @ObservationIgnored
        @Injected(\.networkUtility) private var networkUtility
        
        private var persistent = Persistent<[String:Bool]>(key: "favoriteItems", defaultValue: [:])
        private let item: RealEstateItem
        
        var isFavorite: Bool
        var imagePublishers: [(String, AnyPublisher<UIImage?, Error>)] = []
        var selectedIndex: Int = 0
        
        init(item: RealEstateItem, isFavorite: Bool) {
            self.item = item
            self.isFavorite = isFavorite
        }
        
        override func load() {
            state = .loaded(item)
            
            imagePublishers = item.listing.localization.de.images.compactMap { image in
                if let url = image.urlObject {
                    return (image.url, networkUtility.downloadImage(url: url))
                } else {
                    return nil
                }
            }
        }
        
        func toggleFavorite() {
            isFavorite = !isFavorite
            if isFavorite {
                persistent.value[id] = true
            } else {
                persistent.value[id] = nil
            }
            
        }
    }
}


extension RealEstateItemView.Observed: Identifiable {
    var id: String {
        item.id
    }
}
