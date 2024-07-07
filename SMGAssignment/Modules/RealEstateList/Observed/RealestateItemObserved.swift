//
//  RealestateItemObserved.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import SwiftUI
import Combine

extension RealestateItemView {
    @Observable class Observed: BaseObserved<RealestateItem> {
        @ObservationIgnored
        @Injected(\.networkUtility) private var networkUtility
        
        private var persistent = Persistent<[String:Bool]>(key: "favoriteItems", defaultValue: [:])
        let item: RealestateItem
        
        var isFavorite: Bool
        var imagePublishers: [(String, AnyPublisher<UIImage?, Error>)] = []
        var selectedIndex: Int = 0
        
        init(item: RealestateItem, isFavorite: Bool) {
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


extension RealestateItemView.Observed: Identifiable {
    var id: String {
        item.id
    }
}
