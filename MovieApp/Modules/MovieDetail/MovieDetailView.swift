//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//


import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel = MovieDetailViewModel()
    @Environment(\.managedObjectContext) private var context
    let movieID: Int
    
    var body: some View {
        Group {
            if let movie = viewModel.movie {
                movieDetails(of: movie)
            } else if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                EmptyView(message: viewModel.errorMessage) {
                    viewModel.fetchMovieDetail(id: movieID, context: context)
                }
            }
        }
        .navigationTitle("Details")
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
                 if let url = movie.posterURL {
                     AsyncImage(url: url) { image in
                         image
                             .resizable()
                             .scaledToFit()
                     } placeholder: {
                         ImagePlaceholder()
                     }
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
