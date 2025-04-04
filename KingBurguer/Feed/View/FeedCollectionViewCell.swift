//
//  FeedCollectionViewCell.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 21/02/25.
//

import UIKit

// local para os produtos dentro das sessoes

class FeedCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FeedCollectionViewCell" // criando um identificador para a classe
    
    var product: ProductResponse!{
        willSet {
            if let url = URL(string: newValue.pictureUrl){ // formatar  texto da API
                imageView.sd_setImage(with: url)
            }
            // para o preco da API
            nameLabel.text = newValue.name
            
            if let price = newValue.price.toCurency(){
                priceLabel.text = price
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit // vai encaixar a imagem no tamanho da caixa
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.cornerRadius = 5
        return iv
    } ()
    
    // para o textos dos preços
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center // alinhamento do texto ao centro
        lb.textColor = .red
        lb.font = .systemFont(ofSize: 12)
        lb.text = "Combo KB Kiss"
        return lb
    } ()
    
    
    // para o textos dos produtos
    let priceLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center // alinhamento do texto ao centro
        lb.textColor = .systemBackground
        lb.backgroundColor = .red
        lb.layer.borderWidth = 1
        lb.layer.masksToBounds = true
        lb.layer.borderColor = UIColor.lightText.cgColor
        lb.layer.cornerRadius = 5
        lb.text = "R$ 29,90"
        return lb
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width:  bounds.size.width, height:  bounds.size.height - 80)
        nameLabel.frame = CGRect(x: 0, y: bounds.size.height - 80, width:  bounds.size.width, height: 28)
        priceLabel.frame = CGRect(x: 0, y: bounds.size.height - 40, width: bounds.size.width, height: 38)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
