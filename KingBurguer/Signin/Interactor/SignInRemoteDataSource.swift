//
//  SignInRemoteDataSource.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 14/03/25.
//

import Foundation

class SignInRemoteDataSource {
    
    static let shared = SignInRemoteDataSource()
    
    // funcao do login
    func login(request: SignInRequest, completion: @escaping(SignInResponse?, String?)-> Void){
        WebServiceAPI.shared.call(path: .login, body: request, Method: .post) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
                completion(response, nil)
                break
                
            case .failure(let error, let data):
                print("ERROR: \(error)")
                
                guard let data = data else { return }
                
                switch error {
                case .unauthorized:
                    let response = try? JSONDecoder().decode(ResponseUnauthorized.self, from: data)
                    completion(nil, response?.detail.message)
                    break
                    
                default:
                    let response = try? JSONDecoder().decode(SignUpResponseError.self, from: data)
                    completion(nil, response?.detail)
                    break
                }
                break
            }
        }
    }
}
