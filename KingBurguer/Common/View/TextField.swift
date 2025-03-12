//
//  TextField.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 21/02/25.
//

import Foundation
import UIKit

// criar a propria textField

protocol TextFieldDelegate: UITextFieldDelegate {
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String)
}

class TextField: UIView {
    
    lazy var ed: UITextField = { // criar uma variavel e incluir os componentes (propriedades do objeto)
        let ed = UITextField()
        ed.borderStyle = .roundedRect // vai arredondar a borda da caixa de texto
        ed.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged) // enquanto o texto estiver mudando, vai ativar essa funcao
        ed.translatesAutoresizingMaskIntoConstraints = false //Sinalizada que esta usando o autoLayout -> padrao no IOS
        return ed
    } () // tem que por o () para retornar a variavel
    
    let erroLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .red
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    } ()
    
    var maskField: Mask? // e ? (Opcional) por nao necessariamente o campo precisa de uma mascara -> ex: nome
    
    // para descobrir os Bits dos formularios
    var bitmask: Int = 0
    
    
    var placeholder : String? {
        willSet {
            ed.placeholder = newValue
        }
    }
    
    // para alterar o tipo de teclado
    var keybordType: UIKeyboardType = .default {
        willSet{
            if newValue == .emailAddress {
                ed.autocapitalizationType = .none // if para deixar a primeira letra minuscula 
            }
            ed.keyboardType = newValue
        }
    }
    
    // para ofuscar a senha, deixar ela com as bolinhas
    var secureTextEntry: Bool = false {
        willSet {
            ed.isSecureTextEntry = newValue
            ed.textContentType = .oneTimeCode
        }
    }
    
    // adicionar o delegate na textField
    var delegate: TextFieldDelegate? {
        willSet {
            ed.delegate = newValue
        }
    }
    
    var text : String {
        get { // get retornar o valor do resultado da funcao para o text
            return ed.text!
        }
    }
    
    override var tag: Int {
        willSet {
            super.tag = newValue
            ed.tag = newValue
        }
    }
    
    var returnKeyType: UIReturnKeyType = .next {
        willSet {
            ed.returnKeyType = newValue
        }
    }
// variavel -> funcao sem parametro -> retorna um boll -> que pode ter valor ou nao
    var failure: ( () -> Bool )? // validacao da regra para o e-mail -> funcao dentro de uma variavel
    
    var erro: String?
    
    var heightConstraint: NSLayoutConstraint! // criou a variavel de altura
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(ed)
        addSubview(erroLabel)
        
        let edConstraints = [
            ed.leadingAnchor.constraint(equalTo: leadingAnchor),
            ed.trailingAnchor.constraint(equalTo: trailingAnchor),
            ed.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        let erroLabelConstraints = [
            erroLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            erroLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            erroLabel.topAnchor.constraint(equalTo: ed.bottomAnchor),
        ]
        
        heightConstraint = heightAnchor.constraint(equalToConstant: 50.0) // atribiu valor a variavel de altura
        heightConstraint.isActive = true // ativou a variavel
        
        NSLayoutConstraint.activate(edConstraints)
        NSLayoutConstraint.activate(erroLabelConstraints)
    }
    
    func gainFocus(){
        ed.becomeFirstResponder() // vai fazer que o sai da tela de e-mail para a senha (Botao seguinte)
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) { // ouvir os eventos de touch, quando usuario digitar o app vai entender
        if let mask = maskField { // logica que essa condicional so rode quando o campo houver mascara
            if let res = mask.process(value: textField.text!) { // joga o texto que foi escrito para a mascara
                textField.text = res // se tiver resultado ele retorna o proprio texto escrito
            }
        }
            
        guard let f = failure else {return} // verificar se a funcao tem valor ou nao
        
        if let erro = erro {
            if f() { // condicao para a mensagem de erro desaparecer, ou seja a condicao foi atendida -> no futuro sera se o e-mail esta correto ou nao
                erroLabel.text = erro
                heightConstraint.constant = 70.0 // se o tiver o erro essa e a altura
                delegate?.textFieldDidChanged(isValid: false, bitmask: bitmask, text: textField.text!) // se nao atingir a condicao nao dispara o botao de entrar
            } else {
                erroLabel.text = ""
                heightConstraint.constant = 50.0 // se nao tiver o erro essa e a altura
                delegate?.textFieldDidChanged(isValid: true, bitmask: bitmask, text: textField.text!) // se atingir a condicao libera o botao de entrar
            }
        }
        layoutIfNeeded() // faz com que a constraints seja atualizada (Volta ao valor original)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
