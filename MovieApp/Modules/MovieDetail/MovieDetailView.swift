//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//


import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    @StateObject private var viewModel = MovieDetailViewModel()
    @Environment(\.managedObjectContext) private var context
    let movieID: Int
    
    var body: some View {
        BaseView<MovieDetailViewModel, _>(title: "Details", viewModel: viewModel, content: { vm in
            if let movie = vm.movie {
                movieDetails(of: movie)
            } else {
                ErrorView(message: vm.errorMessage) {
                    vm.fetchMovieDetail(id: movieID, context: context)
                }
            }
        })
        .onAppear {
            viewModel.fetchMovieDetail(id: movieID, context: context)
        }
    }
}

// MARK: - Subviews
extension MovieDetailView {
    @ViewBuilder
    private func movieDetails(of movie: Movie) -> some View {
         ScrollView {
             VStack(alignment: .leading) {
                 if let posterURL = movie.posterURL {
                     KFImage(posterURL)
                         .placeholder { ImagePlaceholder() }
                         .targetCache(ImageCache(name: movie.title))
                         .cacheOriginalImage()
                         .fade(duration: 0.3)
                         .resizable()
                         .scaledToFit()
                         .frame(height: 300)
                         .frame(maxWidth: .infinity)
                         .clipped()
                 } else {
                     ImagePlaceholder()
                         .frame(height: 300)
                         .frame(maxWidth: .infinity)
                         .clipped()
                 }
                 
                 Text(movie.title)
                     .font(.title)
                     .padding(.top)
                 
                 Text("Released: \(movie.releaseYear)")
                     .font(.subheadline)
                     .foregroundColor(.secondary)
                 
                 Text(movie.overview)
                     .padding(.top)
             }
             .padding()
         }
    }
}
