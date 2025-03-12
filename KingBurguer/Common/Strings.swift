//
//  Strings.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 25/02/25.
//

import Foundation

// PADRAO PARA VERIFICACAO DE E-MAIL, SE TEM O FORMATO DE E-MAIL MESMO OU NAO

extension String {
    
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    // logica para tirar apenas os digitos do CPF
    var digits: String{
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    // vai procurar o caracter ate acessar o indice que foi solicitado 
    func charAtIndex(index: Int) -> Character? {
        var indexCurrent = 0
        for char in self {
            if index == indexCurrent {
                return char
            }
            indexCurrent = indexCurrent + 1
        }
        return nil
    }
}
