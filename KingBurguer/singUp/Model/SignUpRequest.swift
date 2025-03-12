//
//  SignUpRequest.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 05/03/25.
//

import Foundation


// para fazer as requisicoes da tela de cadastro

struct SignUpRequest: Encodable {
    let name: String
    let email: String
    let password: String
    let document: String
    let birthday: String
    
    //{"fullname": "UserA}
    
    // para associar uma variavel dentro do programa com o nome da variavel que o servidor espera
    enum codingKeys: String, CodingKey {
        case name = "name" // se no programa tem name, e no servidor tem "fullname" poderia so colocar depois do = que seria feita a associacao
        case email
        case password
        case document
        case birthday
    }
    
}
