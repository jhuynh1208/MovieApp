//
//  APIHelper.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//


import Foundation
import Alamofire

class APIHelper {
    static let shared = APIHelper()
    private init() {}

    func request<T: Decodable>(_ route: APIRouter) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(route)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        continuation.resume(returning: value)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}