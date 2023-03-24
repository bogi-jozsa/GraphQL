//
//  TokensObject.swift
//
//  Created by Vica Cotoarba on 17.09.2021.
//

import Foundation

struct TokenDto: Codable {
    var accessToken: String?
    var createdAt: Double?
    var expiresIn: Int?
    var tokenType: String?
    var refreshToken: String?
    
    var hasTokens: Bool {
        return !(accessToken ?? "").isEmpty && !(refreshToken ?? "").isEmpty
    }
    
    var createdAtDate: Date? {
        guard let timeInterval = createdAt else { return nil }
        return Date(timeIntervalSince1970: timeInterval)
    }
    
    var isValid: Bool {
        guard let expirationDate = createdAtDate else {
            return false
        }
        let expirationSeconds = TimeInterval(expiresIn ?? 0)
        return Date().timeIntervalSince(expirationDate) < expirationSeconds
    }
}
