//
//  SignUpViewController.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 12/02/25.
//

import Foundation
import UIKit

// TELA DE CADASTRO (VISUAL)

// enum com padrao decimal para bits
enum SingUpForm: Int {
    case name = 0x1
    case email = 0x2
    case password = 0x4
    case document = 0x8
    case birthday = 0x10
}

class SignUpViewController: UIViewController {
    
    let scroll: UIScrollView = {
        let sc = UIScrollView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var name: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu nome"
        ed.tag = 1
        ed.bitmask = SingUpForm.name.rawValue
        ed.returnKeyType = .next
        ed.erro = "Nome deve ter no minimo 3 caracteres"
        ed.failure = {
            return ed.text.count < 3
        }
        ed.delegate = self
        return ed
    }()
    
    lazy var email: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu e-mail"
        ed.tag = 2
        ed.bitmask = SingUpForm.email.rawValue
        ed.returnKeyType = .next
        ed.keybordType = .emailAddress
        ed.erro = "E-mail invalido"
        ed.failure = {
            return !ed.text.isEmail()
        }
        ed.delegate = self
        return ed
    }()
    
    lazy var password: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com sua senha"
        ed.tag = 3
        ed.bitmask = SingUpForm.password.rawValue
        ed.returnKeyType = .next
        ed.secureTextEntry = true
        ed.erro = "Password deve ter no minimo 8 caracteres"
        ed.failure = {
            return ed.text.count < 8
        }
        ed.delegate = self
        return ed
    }()
    
    lazy var document: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu CPF"
        ed.tag = 4
        ed.maskField = Mask(mask: "###.###.###-##") // adicinou a class que vai ter a mascara com o padrao -. # sera os numeros 
        ed.bitmask = SingUpForm.document.rawValue
        ed.returnKeyType = .next
        ed.keybordType = .numberPad // teclado com com numeros
        ed.erro = "CPF deve ter no minimo 11 digitos"
        ed.failure = {
            return ed.text.count != 14
        }
        ed.delegate = self
        return ed
    }()
    
    lazy var birthday: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu data de nascimento"
        ed.tag = 5
        ed.maskField = Mask(mask: "##/##/####")
        ed.bitmask = SingUpForm.birthday.rawValue
        ed.returnKeyType = .done
        ed.keybordType = .numberPad
        ed.erro = "Data de nascimento deve ser dd/MM/yyyy"
        ed.failure = {
            let invalidCount = ed.text.count != 10
            // para verificar se a data e uma data real ou seja nao e (32/02/2022)
            let dt = DateFormatter()
            dt.locale = Locale(identifier: "en_US_POSIX")
            dt.dateFormat = "dd/MM/yyyy"
            
            let date = dt.date(from: ed.text)
            
            let invalidDate = date == nil
            
            return invalidDate || invalidCount
        }
        ed.delegate = self
        return ed
    }()
    
    lazy var send: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Entrar"
        btn.enable(false)
        btn.titleColor = .white
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(sendDidTap))
        return btn
    }()
    
    var viewModel: SignUpViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    var bitmaskResult: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        container.addSubview(name)
        container.addSubview(email)
        container.addSubview(password)
        container.addSubview(document)
        container.addSubview(birthday)
        container.addSubview(send)
        
        scroll.addSubview(container)
        view.addSubview(scroll)
        
        let scrollContraints = [
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        let heightConstraint = container.heightAnchor.constraint(equalTo: view.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        
        let containerCosntraints = [
            container.widthAnchor.constraint(equalTo: view.widthAnchor),
            container.topAnchor.constraint(equalTo: scroll.topAnchor),
            container.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            
            container.heightAnchor.constraint(equalToConstant: 490)
        ]
        
        let nameConstraints = [
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            email.topAnchor.constraint(equalTo: container.topAnchor, constant: 70.0),
        ]
        
        let emailConstraints = [
            email.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            email.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10.0),
        ]
        
        let passwordConstraints = [
            password.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10.0),
        ]
        
        let documentConstraints = [
            document.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            document.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            document.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10.0),
        ]
        
        let birthdayConstraints = [
            birthday.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            birthday.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            birthday.topAnchor.constraint(equalTo: document.bottomAnchor, constant: 10.0),
        ]
        
        let sendConstraints = [
            send.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            send.topAnchor.constraint(equalTo: birthday.bottomAnchor, constant: 10.0),
            send.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(documentConstraints)
        NSLayoutConstraint.activate(birthdayConstraints)
        NSLayoutConstraint.activate(sendConstraints)
        
        NSLayoutConstraint.activate(scrollContraints)
        NSLayoutConstraint.activate(containerCosntraints)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardNotification),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardNotification),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func onKeyboardNotification(_ notification: Notification) {
        let visible = notification.name == UIResponder.keyboardWillShowNotification
        
        let keyboardFrame = visible
        ? UIResponder.keyboardFrameEndUserInfoKey
        : UIResponder.keyboardFrameBeginUserInfoKey
        
        if let keyboardSize = (notification.userInfo?[keyboardFrame] as? NSValue)?.cgRectValue {
            onKeyboardChanged(visible, height: keyboardSize.height)
        }
        
    }
    
    func onKeyboardChanged(_ visible: Bool, height: CGFloat) {
        if (!visible) {
            scroll.contentInset = .zero
            scroll.scrollIndicatorInsets = .zero
        } else {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: height, right: 0.0)
            scroll.contentInset = contentInsets
            scroll.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc func sendDidTap(_ sender: UIButton) {
        viewModel?.send()
    }
    
}

extension SignUpViewController: TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            view.endEditing(true)
            print("save!!")
            return false
        }
        
        let nextTag = textField.tag + 1
        let component = container.findViewByTag(tag: nextTag) as? TextField
        
        if (component != nil) {
            component?.gainFocus()
        } else {
            view.endEditing(true)
        }
        
        return false
    }
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String) {
        if isValid {
            self.bitmaskResult = self.bitmaskResult | bitmask
        } else {
            self.bitmaskResult = self.bitmaskResult & ~bitmask
        }
        self.send.enable(
            (SingUpForm.name.rawValue & self.bitmaskResult != 0) &&
            (SingUpForm.email.rawValue & self.bitmaskResult != 0) &&
            (SingUpForm.password.rawValue & self.bitmaskResult != 0) &&
            (SingUpForm.document.rawValue & self.bitmaskResult != 0) &&
            (SingUpForm.birthday.rawValue & self.bitmaskResult != 0)
            )
        
        if bitmask == SingUpForm.name.rawValue {
            viewModel?.name = text
        }
        else if bitmask == SingUpForm.email.rawValue {
            viewModel?.email = text
        }
        else if bitmask == SingUpForm.password.rawValue {
            viewModel?.password = text
        }
        else if bitmask == SingUpForm.document.rawValue {
            viewModel?.document = text
        }
        else if bitmask == SingUpForm.birthday.rawValue {
            viewModel?.birthday = text
        }
    }
}

// TODO: organizar o projeto separando a extension utilitaria
extension UIView {
    func findViewByTag(tag: Int) -> UIView? {
        for subview in subviews {
            if subview.tag == tag {
                return subview
            }
        }
        return nil
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    func viewModelDidChanged(state: SignUpState) {
        switch(state) {
        case .none:
            break
        case .loading:
            send.startLoading(true)
            break
        case .goToLogin:
            send.startLoading(false)
            let alert = UIAlertController(title: "Titulo", message: "Usuario cadastrado com sucesso!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in
                self.viewModel?.goToLogin()
            }))
            self.present(alert, animated: true)
            break
        case .error(let msg):
            send.startLoading(false)
            let alert = UIAlertController(title: "Titulo", message: msg, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            
            self.present(alert, animated: true)
            
            break
        }
    }
}
