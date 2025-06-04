//
//  MovieListView.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//


import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if !viewModel.filteredMovies.isEmpty {
                    moviesList
                } else {
                    if !viewModel.searchText.isEmpty {
                        Text("Movie with title '\(viewModel.searchText)' not found")
                    } else {
                        EmptyView(message: viewModel.errorMessage) {
                            viewModel.fetchMovies(context: context)
                        }
                    }
                }
            }
            .navigationTitle("Popular Movies")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by title")
            .onAppear {
                viewModel.fetchMovies(context: context)
            }
        }
    }
}

// MARK: - Subviews
extension MovieListView {
    @ViewBuilder
    private func movieRow(_ movie: Movie) -> some View {
        HStack {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { image in
                    image.resizable()
                } placeholder: {
                    ImagePlaceholder()
                }
                .frame(width: 50, height: 75)
                .cornerRadius(8)
            } else {
                ImagePlaceholder()
                    .frame(width: 50, height: 75)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.releaseYear)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private var moviesList: some View {
        List(viewModel.filteredMovies) { movie in
            NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                movieRow(movie)
            }
        }
    }
}

#Preview {
    MovieListView()
}
