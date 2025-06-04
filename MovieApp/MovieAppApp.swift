//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//

import SwiftUI

@main
struct MovieAppApp: App {
    let persistentContainer = CoreDataManager.shared.container
    
    var body: some Scene {
        WindowGroup {
            MovieListView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
                
        }
    }
}
