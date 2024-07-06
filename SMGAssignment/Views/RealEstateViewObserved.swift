//
//  RealEstateViewObserved.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import SwiftUI
import Combine

extension RealEstateListView {
    class Observed: BaseObserved<[RealEstateItem]> {
        let service = ListingService()
        
        private var cancellables = Set<AnyCancellable>()
        
        override func load() {
            state = .loading
            service.getListings()
                .sink(
                    receiveCompletion: { [unowned self] completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            self.state = .failed(error)
                        }
                    },
                    receiveValue: { [unowned self] response in
                        self.state = .loaded(response.results)
                    }
                )
                .store(in: &cancellables)
        }
    }
}
