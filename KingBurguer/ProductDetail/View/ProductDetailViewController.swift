//
//  ProductDetailViewController.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 28/03/25.
//

import UIKit
import SDWebImage

class ProductDetailViewController: UIViewController {
    
    var id: Int!
    
    let scroll: UIScrollView = {
        let sc = UIScrollView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let progress: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.backgroundColor = .systemBackground
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    // view de empilhamento
    let container: UIStackView = {
        let v = UIStackView(arrangedSubviews: [])
        v.axis = .vertical // orientacao da view
        v.distribution = .fill
        v.spacing = 10
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    } ()
    
    let containerPrice: UIView = {
        let iv = UIView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    } ()
    
    let nameLbl: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.textColor = .red
        lb.font = .systemFont(ofSize: 20.0)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    } ()
    
    
    let priceLbl: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = .white
        lb.backgroundColor = .red
        lb.font = .systemFont(ofSize: 18.0)
        lb.layer.cornerRadius = 10
        lb.clipsToBounds = true
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    } ()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.setTitle( "Adicionar Cupom", for: .normal)
        btn.layer.borderColor = UIColor.systemBackground.cgColor
        btn.layer.borderWidth = 1
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 5
        btn.contentEdgeInsets = UIEdgeInsets(top:8, left: 8, bottom: 8, right: 8)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(couponTapped), for: .touchUpInside)
        return btn
    }()
    
    let desclbl: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.textColor = .darkText
        lb.numberOfLines = 0
        lb.sizeToFit() // ajustar o tamanho ao container que ele esta inserido
        lb.font = .systemFont(ofSize: 16.0)
        lb.translatesAutoresizingMaskIntoConstraints = false

        return lb
    } ()
    
    var viewModel: ProductDetailViewModel? {
        didSet{
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.fetch(id: id)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .systemBackground
        
        // label empilhada
        containerPrice.addSubview(nameLbl)
        containerPrice.addSubview(priceLbl)
        
        container.addArrangedSubview(imageView)
        container.addArrangedSubview(containerPrice)
        container.addArrangedSubview(desclbl)
        
        
        scroll.addSubview(container)
        
        view.addSubview(scroll)
        view.addSubview(button)
        view.addSubview(progress)
        
        navigationItem.title = "Cupom"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        applyConstraints()
    }
    
    func applyConstraints() {
        let scrollConstraints = [
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let sl = scroll.contentLayoutGuide
        let containerConstraints = [
           // container.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.topAnchor.constraint(equalTo: sl.topAnchor),
            container.leadingAnchor.constraint(equalTo: sl.leadingAnchor,constant: 20),
            container.trailingAnchor.constraint(equalTo: sl.trailingAnchor, constant: -20),
            container.bottomAnchor.constraint(equalTo: sl.bottomAnchor),
        ]
        
        let imageConstraints = [
            imageView.heightAnchor.constraint(equalToConstant: 200),
        ]
        
        let nameConstraints = [
            nameLbl.leadingAnchor.constraint(equalTo: containerPrice.leadingAnchor, constant: 20),
            nameLbl.topAnchor.constraint(equalTo: containerPrice.topAnchor, constant: 10),
        ]
        
        let priceConstraints = [
            priceLbl.trailingAnchor.constraint(equalTo: containerPrice.trailingAnchor, constant: -20),
            priceLbl.topAnchor.constraint(equalTo: containerPrice.topAnchor, constant: 10),
        ]
        
        let containerPriceConstraints = [
            containerPrice.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        let buttonConstraints = [
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        let progressConstraints = [
            progress.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progress.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            progress.topAnchor.constraint(equalTo: view.topAnchor),
        ]
        
        NSLayoutConstraint.activate(buttonConstraints)
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(priceConstraints)
        NSLayoutConstraint.activate(containerPriceConstraints)
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(containerConstraints)
        NSLayoutConstraint.activate(scrollConstraints)
        NSLayoutConstraint.activate(progressConstraints)
    }
    
    @objc func couponTapped(){
        viewModel?.createCoupon(id: id)
    }
}


extension ProductDetailViewController: ProductDetailViewModelDelegate {
    

        func viewModelDidChange(state: ProductDetailState) {
        switch(state) {
        case .loading:
            progress.startAnimating()
            break
        case .success(let response):
            self.nameLbl.text = response.name
            self.desclbl.text = response.description
            
            if let price = response.price.toCurency(){
                self.priceLbl.text = "  \(price)  "
            }
            if let url = URL(string: response.pictureUrl){
                self.imageView.sd_setImage(with: url)
            }
            progress.stopAnimating()
            break
            
        case .successCoupon(let response):
            progress.stopAnimating()
            
            let alert = UIAlertController(title: "KingBurguer", message: "Coupon gerado: \(response.coupon)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in
            }))
            self.present(alert, animated: true)
            
         
            case .error (let msg):
            progress.stopAnimating()
            break
            
        
        }
    }
}
