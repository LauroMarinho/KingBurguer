//
//  LoadingButton.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 16/02/25.
//

import Foundation
import UIKit

class LoadingButton: UIView {
    
    lazy var button: UIButton = { // lazy usamos para inicializacao atrasada, so vai chamar var depois
        let btn = UIButton() // intanciando o botao
        btn.translatesAutoresizingMaskIntoConstraints = false // adicionar o autoLayout ao botao
        return btn
    } ()
    
    let progress: UIActivityIndicatorView = { // sintax para simbolo do carregar
        let p = UIActivityIndicatorView()
        p.translatesAutoresizingMaskIntoConstraints = false
        return p
    } ()
    
    var title: String? {
        willSet {
            button.setTitle(newValue, for: .normal)
        }
    }
    
    var titleColor: UIColor? {
        willSet {
            button.setTitleColor(newValue, for: .normal)
        }
    }
    
    override var backgroundColor: UIColor? {
        willSet {
            button.backgroundColor = newValue
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget(_ target: Any?, action: Selector) { // funcao para ouvir o touch do botao
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    // para deixar o botao transparente de acordo com a condicao
    func enable(_ isEnable: Bool) {
        button.isEnabled = isEnable
        if isEnable {
            alpha = 1
        } else {
            alpha = 0.5
        }
    }
    
    func startLoading (_ loading: Bool) { // inserir o simbolo de carregar
        button.isEnabled = !loading // quando o botao nao for carregando, ele estara funcionando
        if loading {
            button.setTitle("", for: .normal)
            progress.startAnimating() // -> se sim, inicializar a animacao
            alpha = 0.5 // forca da cor do texto - 50%
        } else {
            button.setTitle(title, for: .normal)
            progress.stopAnimating() // -> se nao, nao inicia
            alpha = 1.0 // forca da cor do texto - 100%
        }
    }
    
    private func setupViews () {
        backgroundColor = .yellow
        addSubview(button)
        addSubview(progress)
        
        
        let buttonConstraints = [
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        let progressConstraints = [
            progress.leadingAnchor.constraint(equalTo: leadingAnchor),
            progress.trailingAnchor.constraint(equalTo: trailingAnchor),
            progress.topAnchor.constraint(equalTo: topAnchor),
            progress.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(buttonConstraints)
        NSLayoutConstraint.activate(progressConstraints)
    }
}
