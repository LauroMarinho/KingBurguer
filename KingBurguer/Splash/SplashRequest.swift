//
//  SplashRequest.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 18/03/25.
//

import Foundation


// estrutura para requerimento do splash de acordo com os servidor
//  {
//  "refresh_token": "Aqui vai estar o token que o sistema envia"
//  }

struct SplashRequest: Encodable {
    
    let refreshToken: String
        
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"

    }
    
}

