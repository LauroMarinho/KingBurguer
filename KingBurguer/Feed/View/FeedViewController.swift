//
//  FeedViewController.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 17/02/25.
//

import UIKit

// tela principal do feed

class FeedViewController: UIViewController {
    
    let sections = ["Mais vendidos", "Vegano", "Bovinos", "Sobremesas"]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(homeFeedTable)
        
        // criando um banner , componente de destaque
        let headerView = HighlightView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        headerView.backgroundColor = .orange
        homeFeedTable.tableHeaderView = headerView
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar() // barra de navegacao
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
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
        return 200
    }
    
    // definir tamanho do titulo da sessao
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    
    // adicionar um titulo a sessao
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.bounds.width, height: 40))
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.text = sections[section].uppercased()
        
        view.addSubview(label)
        
        return view
    }
    
    // celula para a linha expecifica
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // as! fez um quest, converteu a classe mae UITableView na classe filha FeedTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        
        // cell.textLabel?.text = "Ola mundo \(indexPath.section) \(indexPath.row)"
        return cell
    }
}
