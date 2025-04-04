//
//  LocalDataSource.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 17/03/25.
//

import Foundation


// Para fazer com o usuario não precise fazer o login sempre, se ele ja tiver feito no aparelho, entra automaticamente
// armazenar e coletar dados locais (No proprio iphone)

class LocalDataSource {
    
    static let shared = LocalDataSource()
    
    // para inserir a estrutura de dados -> inserir usuario no sistema (Encondoble)
    func insertUserAuth(UserAuth: UserAuth) {
        let value = try? PropertyListEncoder().encode(UserAuth)
        UserDefaults.standard.set(value, forKey: "user_key")
    }
    
    // para buscar a estrura de dados -> buscar o usuario no sistema (Decodable)
    func getUserAuth() -> UserAuth? {
        if let data =  UserDefaults.standard.value(forKey: "user_key") as? Data {
            let user = try?PropertyListDecoder().decode(UserAuth.self, from: data)
            return user
        }
        
        return nil
    }
}
