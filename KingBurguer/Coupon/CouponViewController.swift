//
//  CouponViewController.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 17/02/25.
//

import UIKit

class CouponViewController: UIViewController {

    let test: UIView = {
        let v = UIView(frame: CGRect(x:20, y:90, width: 20, height: 20))
        v.backgroundColor = .yellow
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(test)
        
    }

}
