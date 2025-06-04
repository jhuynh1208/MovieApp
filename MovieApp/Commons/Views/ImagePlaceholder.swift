//
//  ImagePlaceholder.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//

import SwiftUI

struct ImagePlaceholder: View {
    var body: some View {
        Image("movie-poster-placeholder")
            .resizable()
            .scaledToFit()
    }
}
