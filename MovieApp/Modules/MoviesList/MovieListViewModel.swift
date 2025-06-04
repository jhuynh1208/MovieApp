//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//


import Foundation
import CoreData

@MainActor
class MovieListViewModel: ObservableObject {
    @Published private var movies: [Movie] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var searchText: String = ""
    @Published var filteredMovies: [Movie] = []

    init() {
        setupSearch()
    }
    
    private func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .combineLatest($movies)
            .map { (searchText, movies) in
                guard !searchText.isEmpty else { return movies }
                return movies.filter {
                    $0.title.lowercased().contains(searchText.lowercased())
                }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$filteredMovies)
    }
    
    func fetchMovies(context: NSManagedObjectContext) {
        Task {
            isLoading = true
            do {
                let response: MovieResponse = try await APIHelper.shared.request(.getPopularMovies)
                self.movies = response.results
                CoreDataManager.shared.saveMovies(response.results, context: context)
            } catch {
                print("API Error:", error.localizedDescription)
                self.errorMessage = "Failed to load movies. Showing cached data..."
                self.movies = CoreDataManager.shared.loadMovies(context: context)
            }
            isLoading = false
        }
    }
}
