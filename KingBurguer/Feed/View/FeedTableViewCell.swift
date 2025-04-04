//
//  FeedTableViewCell.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 18/02/25.
//

import UIKit
import SDWebImage

protocol FeedCollectionViewDelegate {
    func itemSelected(productId: Int)
}


// TELA DA PROPRIA CELULA (TABELA)
class FeedTableViewCell: UITableViewCell {
    
    static let identifier = "FeedTableViewCell" // static e uma variavel da classe e nao do objeto
    
    var products: [ProductResponse] = []
    
    var delegate: FeedCollectionViewDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout() // faz adicionar celulas enquanto houver espaco
        layout.scrollDirection = .horizontal // dentro da sessao a rolagem fica para a horizontal
        layout.itemSize = CGSize(width: 140, height: 220) // tamanho da caixa dentro da sessao
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // cv.backgroundColor = .blue
        cv.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.identifier) // atribuiu a classe do feedColle
        return cv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .systemGreen
        
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension FeedTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, for: indexPath) as! FeedCollectionViewCell
        
        cell.product = products[indexPath.row]
        
        return cell
    }
    // para ouvir os eventos de touch na tela do feed -> UIcollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.itemSelected(productId: products[indexPath.row].id)
    }
    
}
