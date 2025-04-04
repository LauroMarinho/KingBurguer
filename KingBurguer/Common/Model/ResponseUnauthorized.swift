//
//  ResponseUnauthorized.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 12/03/25.
//


import Foundation

struct ResponseUnauthorized: Decodable {
    
    let detail: ResponseDetail
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
    
}

struct ResponseDetail: Decodable {
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
