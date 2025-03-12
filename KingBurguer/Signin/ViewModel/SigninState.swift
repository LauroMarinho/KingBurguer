//
//  SigninState.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 12/02/25.
//

import Foundation

enum SigninState {
    case none
    case loading
    case goToHome
    case error(String)
}
