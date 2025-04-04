//
//  ProductDetailViewModel.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 29/03/25.
//

import Foundation



protocol ProductDetailViewModelDelegate {
    func viewModelDidChange(state: ProductDetailState)
}

class ProductDetailViewModel {

    
    var delegate: ProductDetailViewModelDelegate?
    var coordinator: ProductDetailCoordinator?
    
    var state: ProductDetailState = .loading {
        didSet {
            delegate?.viewModelDidChange(state: state)
        }
    }
    
    private let interactor: ProductDetailInteractor
    
    init (interactor: ProductDetailInteractor) {
        self.interactor = interactor
    }
    
    func fetch (id: Int) {
        self.state = .loading
        interactor.fetch(id: id) { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let response = response {
                    self.state = .success(response)
                }
            }
        }
    }
    
    func createCoupon (id: Int) {
        self.state = .loading
        interactor.createCoupon(id: id) { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let response = response {
                    self.state = .successCoupon(response)
                }
            }
        }
    }
    

//    func goToProductDetail(id: Int){
//        coordinator?.goToProductDetail(id: id)
//    }
}
