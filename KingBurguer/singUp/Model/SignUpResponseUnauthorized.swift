//
//  SignUpRespondeUnauthorized.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 10/03/25.
//

import Foundation

// resposta do servidor para erro

struct SignUpResponseUnauthorized: Decodable {
    
    let detail: SignUpResponseDetail
    
    enum codingKeys: String, CodingKey {
        case detail
    }
        
}

struct SignUpResponseDetail: Decodable {
    
    let message: String
    
    enum codingKeys: String, CodingKey {
        case message
    }
}


