//
//  SignInResponse.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 11/03/25.
//

import Foundation

struct SignInResponse: Decodable {
    
    let accessToken: String
    let refreshToken: String
    let expiresSeconds: Int
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresSeconds = "expires_seconds"
        case tokenType = "token_type"
    }
    
}

