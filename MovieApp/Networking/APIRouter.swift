//
//  APIRouter.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//


import Alamofire
import Foundation

enum APIRouter: URLRequestConvertible {
    case getPopularMovies
    case getMovieDetail(id: Int)

    private var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }

    private var method: HTTPMethod {
        switch self {
        case .getPopularMovies, .getMovieDetail:
            return .get
        }
    }

    private var path: String {
        switch self {
        case .getPopularMovies:
            return "/movie/popular"
        case .getMovieDetail(let id):
            return "/movie/\(id)"
        }
    }

    private var parameters: Parameters? {
        switch self {
        case .getPopularMovies:
            return ["language": "en-US", "page": 1]
        case .getMovieDetail:
            return ["language": "en-US"]
        }
    }

    private var headers: HTTPHeaders {
        [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMzVlNzYyNjU0OTU3MTgyMGY1NTE1MmRhNzYxZGVlOSIsIm5iZiI6MTc0ODg5MjQ5OC42NDEsInN1YiI6IjY4M2RmYjUyNWU4MGQwNGNlYjI4OTE2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.YL5uE6nGOWSv6m2s8iFKIxx9k2NCIZDEhoCGQpIe_jo",
            "Content-Type": "application/json;charset=utf-8"
        ]
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = try URLRequest(url: url, method: method, headers: headers)
        request = try URLEncoding.default.encode(request, with: parameters)
        return request
    }
}
