//
//  UserAuth.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 17/03/25.
//

import Foundation

                // Codable, e tando Encodable, como e Decodable
struct UserAuth: Codable {
    
    let accessToken: String
    let refreshToken: String
    let expiresSeconds: Int
    let tokenType: String
    
}
