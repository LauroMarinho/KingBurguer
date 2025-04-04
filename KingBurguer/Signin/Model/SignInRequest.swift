//
//  SignInRequest.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 11/03/25.
//

import Foundation


struct SignInRequest: Encodable {
    
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
    
}
