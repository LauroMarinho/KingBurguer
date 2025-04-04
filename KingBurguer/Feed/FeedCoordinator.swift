//
//  FeedCoordinator.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 26/03/25.
//

import Foundation
import UIKit


// COORDENADOR DA TELA DE FEED
class FeedCoordinator {
    
    private let navigationController: UINavigationController
    
    var parentCoordinator: HomeCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let interactor = FeedInteractor()
        
        let viewModel = FeedViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let singUpVC = FeedViewController()
        singUpVC.viewModel = viewModel
        
        
        navigationController.pushViewController(singUpVC, animated: true)
    }
    
    func goToProductDetail(id: Int){
        let coordinator = ProductDetailCoordinator(navigationController, id: id)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
}
