//
//  signInCoordinator.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 13/02/25.
//

import Foundation
import UIKit

// COORDENADOR DA TELA DE LOGIN

class SignInCoordinator {
    
    private let window: UIWindow?
    private let navigationController: UINavigationController

    init(window: UIWindow?){
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        // coneccao entre viewController por coordantor e a viewModel
        // tela principal
        let viewModel = SignInViewModel() // crio viewModel
        viewModel.coordinator = self // especifica que o SignInCoordinator o coordinator e o responsavel por isso
        
        let signInVC = SingInViewController() // criou a ViewController
        signInVC.viewModel = viewModel
        
        navigationController.pushViewController(signInVC, animated: true)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible() // Deixar a tela vísivel
    }
    
    func singUp () {
        let singUpCoordinator = SignUpCoordinator(navigationController: navigationController)
        singUpCoordinator.parentCoordinator = self
        singUpCoordinator.start()
        
    }
    
    func home() {
        let homeCoordinator = HomeCoordinator(window: window)
        homeCoordinator.start()
    }
}
