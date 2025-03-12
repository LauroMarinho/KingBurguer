//
//  FeedTableViewCell.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 18/02/25.
//

import UIKit


// TELA DA PROPRIA CELULA (TABELA)
class FeedTableViewCell: UITableViewCell {
    
    static let identifier = "FeedTableViewCell" // static e uma variavel da classe e nao do objeto
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout() // faz adicionar celulas enquanto houver espaco
        layout.scrollDirection = .horizontal // dentro da sessao a rolagem fica para a horizontal
        layout.itemSize = CGSize(width: 140, height: 180) // tamanho da caixa dentro da sessao
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension FeedTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, for: indexPath) as! FeedCollectionViewCell
        
        // logica para para ou impar - vai adicionar a imagem de acordo com o resultado
        if (indexPath.row % 2 == 0) {
            cell.imageView.image = UIImage(named: "example") // se der par
        } else {
            cell.imageView.image = UIImage(named: "logo") // se nao der par ou seja impar
        }
        
        cell.backgroundColor = .systemRed
        
        return cell
    }
}
