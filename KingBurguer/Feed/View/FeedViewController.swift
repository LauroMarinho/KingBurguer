//
//  FeedViewController.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 17/02/25.
//

import UIKit

// tela principal do feed

class FeedViewController: UIViewController {
    
    var sections: [CategoryResponse] = []
    
    private var headerView: HighlightView!
    
    private let progress: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.backgroundColor = .systemBackground
        aiv.startAnimating()
        
        return aiv
    }()
     
    // 1. registrar uma classe que seja UItableViewCell
    // 2. definir o dataSource (viewController)
    // 3. definir os metodos obrigatorios -> numberOfRowsInSection(numero de linhas) | cellForRowAt(renderizacao da linha visual do usuario)
    
    // criar uma tabela
    private let homeFeedTable: UITableView = { // tabela ta tela principal
        let tv = UITableView(frame: .zero, style: .grouped)
        
        // criar a classe que tera em cada umas das ceulas (linhas)
        tv.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        tv.backgroundColor = UIColor.systemBackground // cor da tela principal do inicio
        return tv
    } ()
    
    
    var viewModel: FeedViewModel? {
        didSet{
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.title = "Inicio"
        navigationController?.tabBarItem.image = UIImage(systemName: "house")

        view.addSubview(homeFeedTable)
        view.addSubview(progress)
        
        // criando um banner , componente de destaque
        headerView = HighlightView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 210))
        headerView.backgroundColor = .orange
        homeFeedTable.tableHeaderView = headerView
        
        headerView.delegate = self
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar() // barra de navegacao
        
        viewModel?.fetch()
        viewModel?.fetchHighlight()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
        progress.frame = view.bounds
    }
    
    // funcao para a barra de navegacao superior
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false // titulo grande = true, sem titulo grande = false
        navigationController?.navigationBar.tintColor = UIColor.red
        
        navigationItem.title = "Produtos"  // adicionar titulo no canto superior
        
        // adicionar icon no canto superior esquerdo -> imagem -> item unico
        var image = UIImage(named: "icon") // definiou a imagem como icon que foi feito no assets
        image = image?.withRenderingMode(.alwaysOriginal) // mantem a cor original da imagem
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        // adicionar itens do lado direito -> varios itens [] com o array
        navigationItem.rightBarButtonItems = [
                                            // imagem padrao do IOS                                 adicionar acao ao botao
            UIBarButtonItem(image: UIImage(systemName: "power"), style: .done, target: self, action: #selector(testDidTap)),
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil)
        ]
    }
    
    @objc func testDidTap(_ sender: UIBarButtonItem) {
        print("CLICOU!!!!!")
    }
}


extension FeedViewController: UITableViewDataSource, UITableViewDelegate { // criou a dataSource -> protocolo
    // linhas ficam dentro das sessoes
    // numero de sessoes na tela
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count // contou a quantidade de itens na sections e vai criar as sessoes
    }
    
    // funcoes obrigatorias de serem inseridas abaixo
    // numeros de linha na secao, quantidade de itens na lista
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    // altura da linha dentro da sessao
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    // definir tamanho do titulo da sessao
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    
    // adicionar um titulo a sessao
    func tableView(_ tableView: UITableView, viewForHeaderInSection view: UIView, forsection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 120, height: header.bounds.height)
        header.textLabel?.textColor = .label
    }
    
    // celula para a linha expecifica
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // as! fez um quest, converteu a classe mae UITableView na classe filha FeedTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        
        cell.products.append(contentsOf: sections[indexPath.section].products)
        cell.delegate = self
        
        return cell
    }
}

extension FeedViewController:FeedViewModelDelegate, FeedCollectionViewDelegate, HighlightViewDelegate {
    
    func highlightSelected(productId: Int) {
        viewModel?.goToProductDetail(id: productId)
    }
    
    func itemSelected(productId: Int) {
        viewModel?.goToProductDetail(id: productId)
    }
    
    func viewModelDidChange(state: FeedState) {
        switch(state) {
        case .loading:
            break
        case .success(let response):
            progress.stopAnimating()
            self.sections = response.categories
            self.homeFeedTable.reloadData()
            break
         
        case .successHighlight(let response):
            guard let url = URL(string: response.pictureUrl) else { break }  
            headerView.imagineView.sd_setImage(with: url)
            headerView.productId = response.productId
            break
            
        case .error (let msg):
            progress.stopAnimating()
            self.homeFeedTable.reloadData()
            break
            
        
        }
    }
}
