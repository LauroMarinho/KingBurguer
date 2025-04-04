//
//  UserResponse.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 02/04/25.
//

import Foundation


// resposta para a tela de perfil


struct UserResponse: Decodable {
    
    let id: Int
    let name: String
    let email: String
    let document: String
    let birthday: String
   
}

