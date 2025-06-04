//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//


import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "MovieApp")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data load failed: \(error.localizedDescription)")
            }
        }
    }

    func saveMovies(_ movies: [Movie], context: NSManagedObjectContext) {
        deleteAllMovies(context: context)
        for movie in movies {
            let entity = CDMovie(context: context)
            entity.id = Int64(movie.id)
            entity.title = movie.title
            entity.overview = movie.overview
            entity.releaseDate = movie.release_date
            entity.posterPath = movie.poster_path
        }
        try? context.save()
    }

    func loadMovies(context: NSManagedObjectContext) -> [Movie] {
        let request: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
        let results = (try? context.fetch(request)) ?? []
        return results.map {
            Movie(
                id: Int($0.id),
                title: $0.title ?? "",
                release_date: $0.releaseDate ?? "",
                overview: $0.overview ?? "",
                poster_path: $0.posterPath
            )
        }
    }

    private func deleteAllMovies(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDMovie.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? context.execute(deleteRequest)
    }
}
