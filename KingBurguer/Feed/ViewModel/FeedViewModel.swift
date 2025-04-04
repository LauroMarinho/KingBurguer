//
//  FeedViewModel.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 24/03/25.
//

import Foundation



protocol FeedViewModelDelegate {
    func viewModelDidChange(state: FeedState)
}

class FeedViewModel {

    
    var delegate: FeedViewModelDelegate?
    var coordinator: FeedCoordinator?
    
    var state: FeedState = .loading {
        didSet {
            delegate?.viewModelDidChange(state: state)
        }
    }
    
    private let interactor: FeedInteractor
    
    init (interactor: FeedInteractor) {
        self.interactor = interactor
    }
    
    func fetch () {
        interactor.fetch() { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let response = response {
                    self.state = .success(response)
                }
            }
        }
    }
    
    func fetchHighlight (){
        interactor.fetchHighlight() { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let response = response {
                    self.state = .successHighlight(response)
                }
            }
        }
    }
    
    func goToProductDetail(id: Int){
        coordinator?.goToProductDetail(id: id)
    }
    
    
//    func goToSignUP () {
//        coordinator?.singUp()
//    }
    
//    func goToHome () {
//        coordinator?.home()
//    }
    
}
