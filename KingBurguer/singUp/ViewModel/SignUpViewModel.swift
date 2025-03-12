//
//  SignUpViewModel.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 13/02/25.
//


// LOGICA DA TELA DE CADASTRO
// praticamente igual a tela de login

import Foundation

protocol SignUpViewModelDelegate {
    func viewModelDidChanged(state: SignUpState)
}

class SignUpViewModel {
    
    var name = ""
    var email = ""
    var password = ""
    var document = ""
    var birthday = ""
    
    var delegate: SignUpViewModelDelegate?
    var coordinator: SignUpCoordinator?
    
    var state: SignUpState = .none {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    func send() {
        state = .loading
        
        // string -> date
        let dtString = DateFormatter()
        dtString.locale = Locale(identifier: "en_US_POSIX")
        dtString.dateFormat = "dd/MM/yyyy"
        let date = dtString.date(from: birthday) ?? Date()
        
        
        // date -> string
        let dtDate = DateFormatter ()
        dtDate.locale = Locale(identifier: "en_US_POSIX")
        dtDate.dateFormat = "yyyy-MM-dd"
        let birthdayFormatted = dtDate.string(from: date)
        
        // convertendo o valor do CPF para apenas numero
        let documentFormatted = document.digits
        
        // MAIN-THREAD
        WebServiceAPI.shared.createUser(request: SignUpRequest(name: name,
                                                               email: email,
                                                               password: password,
                                                               document: documentFormatted,
                                                               birthday: birthdayFormatted)){ created, error in
            //xpto-thread(Nao esta na principal)
            DispatchQueue.main.async { // para adicionar na thread principal
                
                // MAIN-THREAD
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let created = created {
                    if created {
                        self.state = .goToLogin
                    }
                }
            }
        }
    }
    
    func goToLogin() {
        coordinator?.login()
    }
    
}
