//
//  Doubles.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 30/03/25.
//

import Foundation

// extensao para comverter valores monetarios
extension Double {
    func toCurency() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "PT-BR")
        
        return formatter.string(from: self as NSNumber)
    }
}
