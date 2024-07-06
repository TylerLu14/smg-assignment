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
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: Spacing.xSmall) {
                ForEach(items) { item in
                    RealEstateItemView(item: item)
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
