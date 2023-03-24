//
//  APIRouter.swift
//
//  Created by Vica Cotoarba on 17.09.2021.
//

import Foundation
import Alamofire

/// Implements APIConfiguration
/// and defines all the routes (or a part of the routes)
enum APIRouter: APIConfiguration {
    
    // MARK: - Accounts
    
    // case login(email: String, password: String)
    case getAllItems
    
    // MARK: - APIConfiguration
    
    var baseUrl: String {
        return Configuration.urlValue(for: .apiUrl)
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllItems:
            return .get
//        case .login:
//            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getAllItems: return "items"
        // case .login: return "login"
        }
    }
    
    var headers: [String: String] {
        var headers: [String: String] = [:]
//        if let token = authService.token {
//            headers["Authorization"] = token
//            print(token)
//        }
        headers["Content-Type"] = "application/json"

        return headers
    }
    
    var parameters: Parameters? {
        switch self {
        // ex: case .register(let request): return request.params
        default: return nil
        }
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        .reloadIgnoringLocalCacheData
    }
    
}
