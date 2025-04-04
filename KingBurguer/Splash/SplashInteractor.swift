//
//  SplashInteractor.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 18/03/25.
//

import Foundation

// classe para fazer o refresh token

class SplashInteractor {
    
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func login(request: SplashRequest, completion: @escaping (SignInResponse?, Bool) -> Void) {
        let userAuth = local.getUserAuth()
        guard let accessToken = userAuth?.accessToken else {
            completion(nil, true)
            return
        }
        
        print(request)
        print(accessToken)

        remote.login(request: request, accessToken: accessToken) { response, error in
            
            if let r = response {
                let userAuth = UserAuth(accessToken: r.accessToken,
                                        refreshToken: r.refreshToken,
                                        expiresSeconds: Int(Date().timeIntervalSince1970 + Double (r.expiresSeconds)),
                                        tokenType: r.tokenType)
                
                self.local .insertUserAuth(UserAuth: userAuth)
            }
            completion(response, error)
        }
        
    }
    
}
