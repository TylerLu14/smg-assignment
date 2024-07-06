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
            AsyncContentView(
                source: observed,
                initialView: { Color.clear },
                loadingView: { ProgressView() },
                errorView: { error in ErrorView(error: error) },
                content: content
            )
            .navigationTitle("SMG Assignment")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        observed.toggleFavorite()
                    }, label: {
                        Image(systemName: observed.isShowFavorite ? "heart.fill" : "heart")
                    })
                }
            }
        }
    }
    
    @ViewBuilder
    func content(observeds: [RealEstateItemView.Observed]) -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(spacing: Spacing.xSmall) {
                ForEach(observeds) { observed in
                    RealEstateItemView(observed: observed)
                }
            }
        }
        .refreshable {
            await observed.refresh()
        }
    }
}

#Preview {
    RealEstateListView()
}
