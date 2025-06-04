//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//


import Foundation
import CoreData

@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchMovieDetail(id: Int, context: NSManagedObjectContext) {
        Task {
            isLoading = true
            do {
                let movie: Movie = try await APIHelper.shared.request(.getMovieDetail(id: id))
                self.movie = movie
            } catch {
                print("Detail Error:", error.localizedDescription)
                self.movie = CoreDataManager.shared.loadMovies(context: context).first(where: { $0.id == id })
                if self.movie == nil {
                    self.errorMessage = "Failed to load movie details."
                }
            }
            isLoading = false
        }
    }
}
