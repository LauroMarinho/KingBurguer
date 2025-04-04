//
//  HighlightResponde.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 26/03/25.
//

import Foundation

// resposta do destaque -> Highlight

struct HighlightResponse: Decodable {
    let id: Int
    let pictureUrl: String
    let createdDate: String
    let productId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case pictureUrl = "picture_url"
        case createdDate = "created_date"
        case productId = "product_id"
    }
}

