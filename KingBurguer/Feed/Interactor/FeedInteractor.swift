//
//  FeedInteractor.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 24/03/25.
//

import Foundation


class FeedInteractor {
    
    private let remote: FeedRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func fetch(completion: @escaping (FeedResponse?, String?) -> Void) {
        let userAuth = local.getUserAuth()
        guard let accessToken = userAuth?.accessToken else {
            completion(nil, "Access Token not found!")
            return
        }
        
        return remote.fetch(accessToken: accessToken, completion: completion)

    }
    
    func fetchHighlight(completion: @escaping (HighlightResponse?, String?) -> Void) {
        let userAuth = local.getUserAuth()
        guard let accessToken = userAuth?.accessToken else {
            completion(nil, "Access Token not found!")
            return
        }
        
        return remote.fetchHighlight(accessToken: accessToken, completion: completion)

    }
}
