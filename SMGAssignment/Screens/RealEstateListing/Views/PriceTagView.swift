//
//  PriceTagView.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import SwiftUI

struct PriceTagView: View {
    var price: Listing.Price
    
    @ViewBuilder
    var body: some View {
        VStack(alignment: .trailing) {
            Text("\(price.currency.currencySymbol)\(price.buy.price)")
                .font(.caption)
                .foregroundStyle(Color(ColorResource.textGray))
        }
        .padding(.horizontal, Spacing.small)
        .padding(.vertical, Spacing.xxSmall)
        .background {
            RoundedRectangle(cornerRadius: Spacing.xxSmall)
                .fill(Color(ColorResource.backgroundWhite))
        }
        .shadow(radius: Spacing.xxSmall)
    }
}
