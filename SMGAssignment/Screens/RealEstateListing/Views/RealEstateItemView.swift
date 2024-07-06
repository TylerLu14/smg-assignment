//
//  RealEstateItemView.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import SwiftUI
import ACarousel

struct RealEstateItemView: View {
    @Injected(\.networkUtility) var networkUtility
    
    @Bindable var observed: Observed
    
    var indexBinding: Binding<Int> {
        Binding(
            get: { observed.selectedIndex },
            set: { observed.selectedIndex = $0 }
        )
    }

    @ViewBuilder
    var body: some View {
        AsyncContentView(
            source: observed,
            content: { item in
            VStack {
                ZStack(alignment: .leading) {
                    ACarousel(
                        observed.imagePublishers,
                        id: \.0,
                        index: indexBinding,
                        spacing: Spacing.zero,
                        headspace: Spacing.zero,
                        sidesScaling: 1
                    ) { url, publisher in
                        VStack {
                            SMGAsyncImage(
                                imagePublisher: publisher,
                                placeHolder: {
                                    Image(ImageResource.icListingPlaceholder)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.width)
                                        .clipped()
                                },
                                content: { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.width)
                                        .clipped()
                                }
                            )
                        }
                    }
                    .frame(height: Size.listingImageHeight)
                    
                    VStack(alignment: .trailing) {
                        HStack{
                            Spacer()
                            PriceTagView(price: item.listing.prices)
                        }
                        Spacer()
                    }
                    .padding(Spacing.medium)
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.black, .clear]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                            )
                            .frame(height: Size.listingImageHeight/4)
                    }
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(item.listing.localization.de.text.title)
                            .font(.title3)
                        HStack {
                            Image(systemName: "location.locationviewfinder")
                            Text("\(item.listing.address.street), \(item.listing.address.country)")
                                .font(.caption)
                        }
                    }
                    .foregroundStyle(Color(ColorResource.textDarkOverlay))
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, Spacing.xxSmall)
                    .padding(.bottom, Spacing.small)
                }
                
                HStack {
                    Button(action: {
                        observed.toggleFavorite()
                    }, label: {
                        HStack {
                            Spacer()
                            Image(systemName: observed.isFavorite ? "heart.fill":  "heart")
                            Text("Add To Favorite")
                            Spacer()
                        }
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Image(systemName: "info.bubble.rtl")
                            Text("Details")
                            Spacer()
                        }
                    })
                }
                .foregroundStyle(Color(ColorResource.textGray))
                .frame(height: Size.buttonHeight)
                
            }
            .background(Color(ColorResource.backgroundGray))
        })
    }
}

