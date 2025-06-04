//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//


import Foundation
import CoreData

@MainActor
class MovieDetailViewModel: BaseViewModel {
    @Published var movie: Movie?

    override init() {
        super.init()
        observeObjects()
    }
    
    private func observeObjects() {
        NetworkMonitor.shared.$isConnected
            .receive(on: DispatchQueue.main)
            .assign(to: \.isConnected, on: self)
            .store(in: &cancellables)
    }
    
    func fetchMovieDetail(id: Int, context: NSManagedObjectContext) {
        Task {
            isLoading = true
            do {
                let movie: Movie = try await APIHelper.shared.request(.getMovieDetail(id: id))
                self.movie = movie
            } catch {
                if isConnected {
                    self.errorMessage = "Detail Error: \(error.localizedDescription)"
                } else {
                    self.errorMessage = "No internet connection. Showing cached data..."

                }
                self.movie = CoreDataManager.shared.loadMovies(context: context).first(where: { $0.id == id })
                if self.movie == nil {
                    self.errorMessage = "Failed to load movie details."
                }
            }
            isLoading = false
        }
    }
}
