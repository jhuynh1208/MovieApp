//
//  MovieListView.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//


import SwiftUI
import Kingfisher

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        NavigationView {
            BaseView<MovieListViewModel, _>(title: "Popular Movies", viewModel: viewModel) { vm in
                if !vm.filteredMovies.isEmpty {
                    moviesList
                } else {
                    if !vm.searchText.isEmpty {
                        Text("Movie with title '\(vm.searchText)' not found")
                    } else {
                        ErrorView(message: vm.errorMessage) {
                            vm.fetchMovies(context: context)
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search movies by title")
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
                KFImage(posterURL)
                    .placeholder { ImagePlaceholder() }
                    .targetCache(ImageCache(name: movie.title))
                    .cacheOriginalImage()
                    .fade(duration: 0.3)
                    .resizable()
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
