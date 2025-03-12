//
//  SignInRequest.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 11/03/25.
//

import Foundation

struct SingInRequest: Encodable {
    
    let username: String
    let password: String


    
    enum codingKeys: String, CodingKey {
        case username
        case password
    }
}
