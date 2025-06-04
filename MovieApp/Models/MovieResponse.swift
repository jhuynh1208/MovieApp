//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//


import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let release_date: String
    let overview: String
    let poster_path: String?

    var releaseYear: String {
        String(release_date.prefix(4))
    }

    var posterURL: URL? {
        guard let path = poster_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}