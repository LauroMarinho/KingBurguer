//
//  SignUpState.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 13/02/25.
//

import Foundation

enum SignUpState {
    case none
    case loading
    case goToLogin
    case error(String)
}
