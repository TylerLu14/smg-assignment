//
//  ErrorView.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation
import SwiftUI
import Combine

struct ErrorView: View {
    var error: Error
    
    @ViewBuilder
    var body: some View {
        VStack {
            Image(ImageResource.icError)
                .resizable()
                .scaledToFit()
            Text(error.localizedDescription)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, Spacing.xxxxLarge)
    }
    
}

#Preview {
    ErrorView(error: URLError(.badURL))
}



