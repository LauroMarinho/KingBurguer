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
    
    let navFeedVC = UINavigationController()
    let navProfileVC = UINavigationController()
        
    init(window: UIWindow?){
        self.window = window
        }
        
    func start() {
        let homeVC = HomeViewController()

        
        let feedCoordinator = FeedCoordinator(navFeedVC)
        feedCoordinator.start()
        
        let profileCoordinator = ProfileCoordinator(navProfileVC)
        profileCoordinator.start()
        
        
        homeVC.setViewControllers([navFeedVC, navProfileVC], animated: true)
        
        // aqui e onde acontece a troca de navegation controller 
        window?.rootViewController = homeVC
    }

}
