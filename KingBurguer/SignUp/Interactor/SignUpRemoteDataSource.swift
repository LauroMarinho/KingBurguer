//
//  SignUpRemoteDataSource.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 12/03/25.
//

import Foundation

class SignUpRemoteDataSource {
    
    static let shared = SignUpRemoteDataSource()
    
    func createUser(request: SignUpRequest, completion: @escaping (Bool?, String?) -> Void) {
        WebServiceAPI.shared.call(path: .createUser, body: request) { result in
            switch result {
                case .success(let data):
                    guard let data = data else { return }
                    // let response = try? JSONDecoder().decode(SignUpResponse.self, from: data)
                    completion(true, nil)
                    break
                    
                case .failure(let error, let data):
                    print("ERROR: \(error)")
                    
                    guard let data = data else { return }
                    
                    switch error {
                        case .unauthorized:
                            let response = try? JSONDecoder().decode(ResponseUnauthorized.self, from: data)
                            completion(nil, response?.detail.message)
                            break
                            
                        case .badRequest:
                            let response = try? JSONDecoder().decode(SignUpResponseError.self, from: data)
                            completion(nil, response?.detail)
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
