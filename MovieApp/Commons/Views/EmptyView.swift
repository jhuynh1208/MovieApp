//
//  MoviePosterView.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//

import SwiftUI

struct EmptyView: View {
    var message: String?
    var action: () -> Void
    

    var body: some View {
        VStack(spacing: 16) {
            Text(message ?? "There are some error right now. Please try again.")
            Button("Retry") {
                action()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}
