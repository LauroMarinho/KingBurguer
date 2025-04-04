//
//  ProductDetailInteractor.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 29/03/25.
//

import Foundation

class ProductDetailInteractor {
    
    private let remote: ProductDetailRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func fetch(id: Int, completion: @escaping (ProductResponse?, String?) -> Void) {
        let userAuth = local.getUserAuth()
        guard let accessToken = userAuth?.accessToken else {
            completion(nil, "Access Token not found!")
            return
        }
        
        return remote.fetch(id: id, accessToken: accessToken, completion: completion)

    }
    
    func createCoupon(id: Int, completion: @escaping (CouponResponse?, String?) -> Void) {
        let userAuth = local.getUserAuth()
        guard let accessToken = userAuth?.accessToken else {
            completion(nil, "Access Token not found!")
            return
        }
        
        return remote.createCoupon(id: id, accessToken: accessToken, completion: completion)

    }
    
}
