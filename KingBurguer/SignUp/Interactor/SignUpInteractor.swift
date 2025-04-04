//
//  SignUpInteractor.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 12/03/25.
//

import Foundation


class SignUpInteractor {
    
    private let remote: SignUpRemoteDataSource = .shared
    
    func createUser(request: SignUpRequest, completion: @escaping (Bool?, String?) -> Void) {
        remote.createUser(request: request, completion: completion)
    }
    
}
