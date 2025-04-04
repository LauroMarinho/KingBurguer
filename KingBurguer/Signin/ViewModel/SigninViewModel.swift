//
//  SigninViewModel.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 11/02/25.
//

import Foundation

// LOGICA DA TELA DE LOGIN

protocol SignInViewModelDelegate { // conexao do viewModel com a viewController
    func viewModelDidChange(state: SigninState) // -> delegate ativado devolve para a viewController
}

class SignInViewModel {
    
    var email = ""
    var password = ""
    
    var delegate: SignInViewModelDelegate?
    var coordinator: SignInCoordinator?
    
    var state: SigninState = .none {
        didSet { // funcao sera ativada quando o resultado for diferente do definido
            delegate?.viewModelDidChange(state: state) // -> apos mudar o valor na funcao send, ativa a funcao e ativa o delegate.
        }
    }
    
    private let interactor: SignInInteractor
    
    init (interactor: SignInInteractor) {
        self.interactor = interactor
    }
    
    func send () { // -> vai receber o send da viewController
        state = .loading // mudando o valor da variael state
        
        interactor.login(request: SignInRequest(username: email,
                                                password: password)) { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else {
                    print(response)
                    self.state = .goToHome
                }
            }
        }
    }
    
    func goToSignUP () {
        coordinator?.singUp()
    }
    
    func goToHome () {
        coordinator?.home()
    }
    
}
