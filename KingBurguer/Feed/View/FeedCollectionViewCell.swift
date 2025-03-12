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
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill // destaca a imagem, coloca ela para a frente
        iv.clipsToBounds = true // cortar as arestas da imagem caso ela seja muito grande
        return iv
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = bounds   // imagem vai preencher a caixa inteira
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
