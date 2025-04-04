//
//  HomeViewController.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 14/02/25.
//

import Foundation
import UIKit

class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // instanciar as abas - feed, cupom e perfil
        
//        let feedInteractor = FeedInteractor ()
//        let feedViewModel = FeedViewModel(interactor: feedInteractor)
        
//        let feedVC = FeedViewController()
//        feedVC.viewModel = feedViewModel
        

//        let couponVC = UINavigationController(rootViewController: CouponViewController())
//        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        
        // titulo para as imagens

//        couponVC.title = "Cupons"
//        profileVC.title = "Perfil"
        
        // cor do titulo e do simbolos
        tabBar.tintColor = .red
        
        // ativar simbolos do IOS - sf simbols

//        couponVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
//       profileVC.tabBarItem.image = UIImage(systemName: "person.circle")
        
       
    }
}
