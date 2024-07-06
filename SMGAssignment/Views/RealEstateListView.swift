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
        AsyncContentView(
            source: observed,
            initialView: { Color.clear },
            loadingView: { Text("Loading") },
            errorView: { _ in Color.clear },
            content: content
        )
    }
    
    @ViewBuilder
    func content(items: [RealEstateItem]) -> some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: Spacing.medium) {
                    ForEach(items) { item in
                        ForEach(item.listing.localization.de.attachments, id: \.url) { listing in
                            if let url = listing.imgURL {
                                AsyncImage(
                                    url: url,
                                    content: { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    },
                                    placeholder: {
                                        Image(ImageNames.icListingPlaceholder)
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
            .navigationTitle("SMG Assignment")
        }
    }
}

#Preview {
    RealEstateListView()
}
