//
//  SigninViewController.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 28/01/25.
//

import Foundation
import UIKit

// TELA DE LOGIN (VISUAL)


enum SignInForm: Int { // enum para definir os bits
    case email = 0x1
    case password = 0x2
}

class SingInViewController: UIViewController {
    
    let scroll: UIScrollView = {
        let sc = UIScrollView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    } ()
    
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    } ()
        
    
    // 1. definicao de layout
    lazy var email: TextField = { // criou o proprio TextField
        let ed = TextField()
        ed.placeholder = "Entre com seu e-mail" // campo de texto (dica do que fazer naquela caixa)
        ed.returnKeyType = .next // muda o nome do botao de retorno do teclado do iphone para seguinte
        ed.erro = "E-mai invalido"
        ed.keybordType = .emailAddress // altera o tipo de teclado para teclado de e-email, tem varias opcoes
        // forma tradicional
        //ed.failure = validation // validacao da regra
        ed.bitmask = SignInForm.email.rawValue // rawValue e para pegar o valor
        
        // forma enxuta
        ed.failure = {
            return !ed.text.isEmail() // vai verificar se tem formato de e-mail =-> oi@oi.com
        }
        ed.delegate = self // -> vai criar uma nova extension
        return ed
    } () // tem que por o () para retornar a variavel
    
    // forma tradicional
    // ( () -> Bool )? -> tem que usar o mesmo valor da funcao que foi criada dentro da variavel na TextField
//    func validation () -> Bool { // validacao da regra
//        return email.text.count <= 3
        
//    }
    
    // Mesmo passo de cima para a criacao do password
    
    lazy var password : TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com sua senha"
        ed.returnKeyType = .done // muda o nome do botao de retorno do teclado do iphone para concluido
        ed.erro = "Senha deve ter no minimo 8 caracteres"
        ed.secureTextEntry = true
        ed.bitmask = SignInForm.password.rawValue
        ed.failure = {
            return ed.text.count < 8
        }
        ed.delegate = self
        return ed
    } ()
    
    // criar um botao -> UIbutton
    lazy var send: LoadingButton = { // lazy usamos para inicializacao atrasada, so vai chamar var depois
        let btn = LoadingButton() // intanciando o botao
        btn.title = "Entrar"
        btn.backgroundColor = .red // cor de fundo do botao
        btn.enable(false) // inicia o botao desativado -> so quando a logica for atendida que sera liberado
        btn.addTarget(self, action: #selector(sendDidTap)) // add toque no botao
        return btn
    } ()
    
    // criar um botao de criar conta
    lazy var register: UIButton = {
        let btn = UIButton()
        btn.setTitle("Criar conta", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(registerDidTap), for: .touchUpInside) // add toque no botao
        return btn
    } ()
    
    
    var viewModel: SignInViewModel? { // criou a conexao com o viewModel
        didSet{
            viewModel?.delegate = self
        }
    }
    
    var bitmaskResult: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // quando for enum podemos omitir o nome da enum (abaixo poderia ser so .green)
        view.backgroundColor = .systemBackground // view principal
        
        navigationItem.title = "Login"
        
        container.addSubview(email)
        container.addSubview(password)
        container.addSubview(send)
        container.addSubview(register)
        
        scroll.addSubview(container)
        view.addSubview(scroll)
        
        let scrollConstraints = [
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        
        let heightConstraints = container.heightAnchor.constraint(equalTo:view.heightAnchor)
        heightConstraints.priority = .defaultLow
        heightConstraints.isActive = true
        
        let containerConstraints = [
            container.widthAnchor.constraint(equalTo: view.widthAnchor),
            container.topAnchor.constraint(equalTo: scroll.topAnchor),
            container.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            
            container.heightAnchor.constraint(equalToConstant: 490)
        ]
        
        let emailConstraints = [ //autoLayout->Constraint
            //1. as coordenadas a esqueda, alinhamento a esquerda do retangulo
            email.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            // 2. as coordenadas a direita, alinhamento a direita do retangulo
            email.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            // 3. as coordenadas de posicao do retangulo
            email.centerYAnchor.constraint(equalTo: container   .centerYAnchor, constant: -150.0),
            // 4. tamanho do retangulo - fixo
        ]
        let passwordConstraints = [
            password.leadingAnchor.constraint(equalTo: email.leadingAnchor), // passoword alinhado ao email direito
            password.trailingAnchor.constraint(equalTo: email.trailingAnchor), // passoword alinhado ao email esque
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10.0), // topo do password 10 pontos baixo do butao do e-mail.
        ]
        
        let sendConstraints = [
            send.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            send.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10.0),
            send.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let registerConstraints = [
            register.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            register.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            register.topAnchor.constraint(equalTo: send.bottomAnchor, constant: 15.0),
            register.heightAnchor.constraint(equalToConstant: 50.0)
            ]
        
        
        NSLayoutConstraint.activate(emailConstraints) // vai ativar o autoLayout do e-mail
        NSLayoutConstraint.activate(passwordConstraints) // ativa o autoLayout do password
        NSLayoutConstraint.activate(sendConstraints) // ativa o autolayout do botao de entrar
        NSLayoutConstraint.activate(registerConstraints) // ativa autoLayout do botao de registro
        
        NSLayoutConstraint.activate(scrollConstraints)
        NSLayoutConstraint.activate(containerConstraints)
    
        NotificationCenter.default.addObserver(self, selector: #selector (onKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector (onKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
            
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
    
    func onKeyboardChanged(_ visible: Bool, height: CGFloat){
        if (!visible){
            scroll.contentInset = .zero
            scroll.scrollIndicatorInsets = .zero
        } else {
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            scroll.contentInset = contentInset
            scroll.scrollIndicatorInsets = contentInset
        }
    }
    
    // gerenciamento do teclado (touch na tela)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // ouvir qualquer evento do touch no app (fora do que ja tem definicao -> botao, caixa de texto e etc)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        // dentro do que foi definido -> view (tela toda)
        view.addGestureRecognizer(tap)
    }
    // esconder o teclado
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // 2. eventos de touch
    @objc func sendDidTap(_ sender: UIButton) {
        viewModel?.send() // -> quando apertar o botao, o send vai enviar para o viewModel
    }
    
    // navegacao entre telas
    @objc func registerDidTap(_ sender: UIButton) {
        // quando clicar no botao de cadastrar, envia para a viewModel do signin
        viewModel?.goToSignUP()
    }
    
   
}

extension SingInViewController: TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // evento que sera disparado sempre que clicar no antigo botao retorno
        if (textField.returnKeyType == .done) { // condicao para quando cair no botao da senha if -> .done}
            view.endEditing(true) // esconder o teclado depois que clicar em concluido
            print("Entrar!!!")
        } else {
            password.gainFocus() // para que quando clicar no botao seguinte depois de por o e-mail, ir automaticamente para o password
        }
        return false
    }
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String) {
        if isValid { // if para a validacao de condicao de e-mail e senha ok
            // para guardar o valor depois da codicao der ok -> se der true as duas | vai da ok
            self.bitmaskResult = self.bitmaskResult | bitmask
        } else { // para quando o usuario apagar ou modificar o texto que fique fora do padrao
            self.bitmaskResult = self.bitmaskResult & ~bitmask
        }
        // Para que o botao so seja ativado quando a condicao for aceita
        //                para verificar se os dois campo estao validos -> email && senha = true
        self.send.enable((SignInForm.email.rawValue & self.bitmaskResult != 0) && (SignInForm.password.rawValue & self.bitmaskResult != 0))
        
        if bitmask == SignInForm.email.rawValue {
            viewModel?.email = text
        }
        else if bitmask == SignInForm.password.rawValue {
            viewModel?.password = text
        }
    }
}



// 3. Observadores
//extension usado para colocar os observadores (conecao com o view model)

extension SingInViewController: SignInViewModelDelegate {
    // -> a devolucao da funcao delegate
    func viewModelDidChange(state: SigninState) {
        switch(state){
            case.none:
                break
            case.loading:
            // mostrar a progress
            send.startLoading(true)
                break
            case.goToHome:
            send.startLoading(false)
            // navegar para a tela principal
            viewModel?.goToHome()
                break
        case.error(let msg):
            self.send.startLoading(false)
            // alerta padrao do IOS
            let alert = UIAlertController(title: "KingBurguer", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            break
        }
        
    }
}
