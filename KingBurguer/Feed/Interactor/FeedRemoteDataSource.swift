//
//  FeedRemoteDataSource.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 24/03/25.
//

import Foundation

class FeedRemoteDataSource {
    
    static let shared = FeedRemoteDataSource()
    
    
    func fetch(accessToken: String, completion: @escaping(FeedResponse?, String?)-> Void){
        WebServiceAPI.shared.call(path: .feed, body: Optional<FeedRequest>.none, Method: .get, accessToken: accessToken) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                let response = try? JSONDecoder().decode(FeedResponse.self, from: data)
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
    
    
    func fetchHighlight(accessToken: String, completion: @escaping(HighlightResponse?, String?)-> Void){
        WebServiceAPI.shared.call(path:.hightlights , body: Optional<FeedRequest>.none, Method: .get, accessToken: accessToken) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                let response = try? JSONDecoder().decode(HighlightResponse.self, from: data)
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
