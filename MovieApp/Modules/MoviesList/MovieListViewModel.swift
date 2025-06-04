//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//


import Foundation
import CoreData
import Combine

@MainActor
class MovieListViewModel: BaseViewModel {
    @Published private var movies: [Movie] = []
    @Published var searchText: String = ""
    @Published var filteredMovies: [Movie] = []
    
    override init() {
        super.init()
        observeObjects()
    }
    
    private func observeObjects() {
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
        
        NetworkMonitor.shared.$isConnected
            .receive(on: DispatchQueue.main)
//            .assign(to: \.isConnected, on: self)
            .sink(receiveValue: { [weak self] conectionStatus in
                self?.isConnected = conectionStatus
                if !conectionStatus {
                    self?.errorMessage = "No internet connection. Showing cached data..."
                }
            })
            .store(in: &cancellables)
    }
    
    func fetchMovies(context: NSManagedObjectContext) {
        if isConnected {
            Task {
                isLoading = true
                do {
                    let response: MovieResponse = try await APIHelper.shared.request(.getPopularMovies)
                    self.movies = response.results
                    CoreDataManager.shared.saveMovies(response.results, context: context)
                } catch {
                    if !isConnected {
                        self.errorMessage = "No internet connection. Showing cached data..."
                    } else {
                        self.errorMessage = "API Error: \(error.localizedDescription)"
                    }
                    self.movies = CoreDataManager.shared.loadMovies(context: context)
                }
                isLoading = false
            }
        }
    }
}
