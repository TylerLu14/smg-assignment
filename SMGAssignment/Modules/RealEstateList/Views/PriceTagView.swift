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
                .padding(.vertical, Spacing.small)
                .padding(.leading, Spacing.medium)
                .padding(.trailing, Spacing.small)
                .font(.caption2)
                .foregroundStyle(Color(ColorResource.textGray))
        }
        .background {
            PriceTagShape()
                .fill(Color(ColorResource.backgroundWhite))
        }
        .shadow(radius: Spacing.xxSmall)
    }
}
