//
//  RealEstateItemView.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import SwiftUI
import ACarousel

struct RealEstateItemView: View {
    var item: RealEstateItem
    
    @ViewBuilder
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                ACarousel(
                    item.listing.localization.de.images,
                    id: \.url,
                    spacing: Spacing.zero,
                    headspace: Spacing.zero,
                    sidesScaling: 1
                ) { image in
                    VStack {
                        AsyncImage(
                            url: image.urlObject,
                            content: { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width)
                                    .clipped()
                            },
                            placeholder: {
                                Image(ImageResource.icListingPlaceholder)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width)
                                    .clipped()
                            }
                        )
                    }
                }
                .frame(height: Size.listingImageHeight)
                
                
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
                        .frame(height: Size.listingImageHeight/2)
                }
                
                VStack(alignment: .leading) {
                    Spacer()
                    Text(item.listing.localization.de.text.title)
                    Text("\(item.listing.address.street), \(item.listing.address.country)")
                }
                .foregroundStyle(Color(ColorResource.textDarkOverlay))
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, Spacing.xxSmall)
                .padding(.bottom, Spacing.small)
            }
            
            HStack {
                Button(action: {
                    
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "heart")
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
    }
}

