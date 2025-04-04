//
//  ProfileCoordinator.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 31/03/25.
//


import UIKit

// COORDENADOR DA TELA DE PROFILE
class ProfileCoordinator {
    
    private let navigationController: UINavigationController
    
    var parentCoordinator: HomeCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let interactor = ProfileInteractor()
        
        let viewModel = ProfileViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let vc = ProfileViewController(style: .plain)
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
