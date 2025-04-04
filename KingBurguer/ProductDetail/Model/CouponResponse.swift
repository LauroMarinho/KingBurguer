//
//  CouponResponse.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 31/03/25.
//

import Foundation

// RESPOSTA DO COUPON

struct CouponResponse: Decodable {
    let id: Int
    let coupon: String
    let createdDate: String
    let productId: Int
    let userID: Int
    let expiresDate: String

    
    enum CodingKeys: String, CodingKey {
        case id
        case coupon
        case createdDate = "created_date"
        case productId = "product_id"
        case userID = "user_id"
        case expiresDate = "expires_date"
    }
}
