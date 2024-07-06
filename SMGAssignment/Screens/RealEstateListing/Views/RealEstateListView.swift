//
//  RealEstateListView.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation
import SwiftUI
import Combine

struct RealEstateListView: View {
    @State var observed = Observed()
    
    var body: some View {
        NavigationStack {
            VStack {
                AsyncContentView(
                    source: observed,
                    initialView: { Color.clear },
                    loadingView: { ProgressView() },
                    errorView: { error in ErrorView(error: error) },
                    content: content
                )
                .navigationTitle("SMG Assignment")
            }
        }
    }
    
    @ViewBuilder
    func content(items: [RealEstateItem]) -> some View {
        ScrollView {
            LazyVStack(spacing: Spacing.medium) {
                ForEach(items) { item in
                    ForEach(item.listing.localization.de.images, id: \.url) { listing in
                        if let url = listing.urlObject {
                            AsyncImage(
                                url: url,
                                content: { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                },
                                placeholder: {
                                    Image(ImageResource.icListingPlaceholder)
                                        .resizable()
                                        .padding(Spacing.xxLarge)
                                        .scaledToFill()
                                }
                            )
                            .frame(height: 300)
                            .clipped()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RealEstateListView()
}
