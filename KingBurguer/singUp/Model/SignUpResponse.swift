//
//  SignUpResponse.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 11/03/25.
//

import Foundation

// resposta do servidor para sucesso - 200

import Foundation


struct SignUpResponse: Decodable {
    let id: Int
    let name: String
    let email: String
    let document: String
    let birthday: String
    

    enum codingKeys: String, CodingKey {
        case id
        case name
        case email
        case document
        case birthday
    }
    
}
