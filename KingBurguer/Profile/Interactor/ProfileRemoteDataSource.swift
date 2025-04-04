//
//  ProfileRemoteDataSource.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 02/04/25.
//

import Foundation

class ProfileRemoteDataSource {
    
    static let shared = ProfileRemoteDataSource()
    
    func fetch(accessToken: String, completion: @escaping (UserResponse?, String?) -> Void) {
        WebServiceAPI.shared.call(path: .me, body: Optional<FeedRequest>.none, Method: .get, accessToken: accessToken) { result in
            switch result {
                case .success(let data):
                    guard let data = data else { return }
                    let response = try? JSONDecoder().decode(UserResponse.self, from: data)
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
