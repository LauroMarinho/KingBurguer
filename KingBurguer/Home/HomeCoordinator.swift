//
//  HomeCoordinator.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 14/02/25.
//

import Foundation
import UIKit

class HomeCoordinator {
    
    private let window: UIWindow?
        
    init(window: UIWindow?){
        self.window = window
        }
        
    func start() {
        let homeVC = HomeViewController()
        
        // aqui e onde acontece a troca de navegation controller 
        window?.rootViewController = homeVC
    }

}
