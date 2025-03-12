//
//  SignUpResponseError.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 10/03/25.
//

import Foundation

// resposta do servidor para erro geral

struct SignUpResponseError: Decodable {
    
    let detail: String
    
    enum codingKeys: String, CodingKey {
        case detail
    }
}
