//
//  HighlightView.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 18/02/25.
//

import UIKit

protocol HighlightViewDelegate {
    func highlightSelected(productId: Int)
}

// View do banner de destaque

class HighlightView: UIView {
    
    // adicionar a imagem
        let imagineView: UIImageView = {
        let iv = UIImageView()
            iv.contentMode = .scaleAspectFit // ajustar a imagem a caixa
        iv.image = UIImage(named: "highlight")
        iv.clipsToBounds = true
        return iv
    } ()
    
    var productId: Int!
    
    var delegate: HighlightViewDelegate?
    
    // adicionar botao no banner
    private let moreButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Resgatar Cupom", for: .normal)
        btn.layer.borderColor = UIColor.systemBackground.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5 // arredondar bordas
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right:8)
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    } ()
    
    @objc func buttonTapped() {
        delegate?.highlightSelected(productId: productId)
    }
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(imagineView)
        
        addGradiente()
        // add a subview do butao
        addSubview(moreButton)
        applyConstraints()
    }
    
    private func addGradiente () {
        let gradientLayer = CAGradientLayer()
        // cria o gradiente, para deixar a imagem com degrade
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor,  UIColor.black.cgColor]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    
    private func applyConstraints() {
        // constratrains do botao
        let moreButtonConstraints = [
            moreButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -8),
            moreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ]
        // ativar o botao
        NSLayoutConstraint.activate(moreButtonConstraints)
    }
    
    // imprimir a imagem no app
    override func layoutSubviews() {
        super.layoutSubviews()
        imagineView.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


