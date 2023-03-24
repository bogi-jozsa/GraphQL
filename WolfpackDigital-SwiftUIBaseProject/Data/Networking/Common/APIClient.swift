//
//  APIClient.swift
//
//  Created by Vica Cotoarba on 17.09.2021.
//
// swiftlint:disable force_cast

import Foundation
import Alamofire

// MARK: - API Client

/// Protocol that's used by concrete APIs to perform requests
/// This can also be adopted by concrete classes which will then handle custom API requests
protocol APIClient: AnyObject {
    func performRequest<T: Decodable>(route: APIConfiguration) async throws -> T
}

// MARK: - Default Implementation

/// Used for most of the API requests
extension APIClient {
    
    func performRequest<T: Decodable>(route: APIConfiguration) async throws -> T {
        return try await withCheckedThrowingContinuation({ continuation in
            AF.request(route)
                .validate()
                .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
    
}
