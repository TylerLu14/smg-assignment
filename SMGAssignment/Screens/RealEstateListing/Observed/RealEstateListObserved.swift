//
//  RealEstateViewObserved.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import SwiftUI
import Combine

extension RealEstateListView {
    @Observable
    class Observed: BaseObserved<[RealEstateItemView.Observed]> {
        private let service = InjectedValues[\.listingService]
        private var persistent = Persistent<[String:Bool]>(key: "favoriteItems", defaultValue: [:])
        
        private var cancellables = Set<AnyCancellable>()
        
        var isShowFavorite: Bool = false
        var items: [RealEstateItemView.Observed] = []
        
        override func load() {
            state = .loading
            service.getListings()
                .sink(
                    receiveCompletion: { [unowned self] completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            state = .failed(error)
                        }
                    },
                    receiveValue: { [unowned self] response in
                        items = response.results.map {
                            RealEstateItemView.Observed(
                                item: $0,
                                isFavorite: persistent.value[$0.id] ?? false
                            )
                        }
                        reloadItems()
                    }
                )
                .store(in: &cancellables)
        }
        
        func refresh() async {
            do {
                let response = try await service.getListings()
                items = response.results.map {
                    RealEstateItemView.Observed(
                        item: $0,
                        isFavorite: persistent.value[$0.id] ?? false
                    )
                }
                reloadItems()
            } catch {
                state = .failed(error)
            }
        }
        
        func toggleFavorite() {
            isShowFavorite = !isShowFavorite
            withAnimation {
                reloadItems()
            }
        }
        
        private func reloadItems() {
            if isShowFavorite {
                state = .loaded(items.filter { $0.isFavorite })
            } else {
                state = .loaded(items)
            }
        }
    }
}
