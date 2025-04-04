//
//  File.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 29/03/25.
//

import Foundation


enum ProductDetailState {
    case loading
    case success(ProductResponse)
    case successCoupon(CouponResponse)
    case error(String)
}
