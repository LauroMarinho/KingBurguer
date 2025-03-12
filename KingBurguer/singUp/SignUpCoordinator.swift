//
//  SignUpCoordinator.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 13/02/25.
//

import Foundation
import UIKit


// COORDENADOR DA TELA DE CADASTRO 
class SignUpCoordinator {
    
    private let navigationController: UINavigationController
    
    var parentCoordinator: SignInCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let viewModel = SignUpViewModel()
        viewModel.coordinator = self
        
        let singUpVC = SignUpViewController()
        singUpVC.viewModel = viewModel
        
        
        navigationController.pushViewController(singUpVC, animated: true)
    }
    
    func login() {
        navigationController.popViewController(animated: true)
    }
}
