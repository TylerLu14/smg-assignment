//
//  SMGAsyncImage.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import SwiftUI
import Combine

struct SMGAsyncImage<Content:View, PV: View> : View {
    @State var imagePublisher: AnyPublisher<UIImage?, Error>
    
    var placeHolder: () -> PV
    var content: (Image) -> Content
    
    @ViewBuilder
    var body: some View {
        AsyncContentView(
            publisher: imagePublisher,
            initialView: { Color.clear },
            loadingView: { ProgressView() },
            errorView: { _ in
                placeHolder()
            },
            content: { uiImage in
                if let uiImage = uiImage {
                    content(Image(uiImage: uiImage))
                } else {
                    placeHolder()
                }
            }
        )
    }
}
