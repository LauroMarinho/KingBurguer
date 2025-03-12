//
//  Mask.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 28/02/25.
//

import Foundation
import UIKit

// criar definicoes para incluir no campo do texto parametro automaticos -> ex cpf: 000.000.000-00 ou data de nascimento _/_/_

class Mask {
    
    private let mask: String
    var oldString = ""
    
    init(mask: String) {
        self.mask = mask
    }
    
    private func replaceChars(value: String) -> String{ // se receber str com -,. e etc, vamos remover os carac especiais
        return value.replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "/", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
    
    func process (value: String) -> String? { // logica para descobrir se o imput do usuario corresponde a nossa mascara ###.###.###-##
        // para remover o caracter excedente do tamanho correto da mascara
        if value.count > mask.count {
            return String(value.dropLast())
        }
        
        // variavel para remover os caracteres especiais
        let str = replaceChars(value: value)
        
        let isDeleting = str <= oldString // logica para saber se o usuario esta apagando o texto
        
        if value.count == mask.count{
            return nil
        }
        
        oldString = str
        
        var result = ""
        
        //###.###.###-##
        // logica para fazer o looping em toda essa mascara em todos os caracters da string -> usando o for
        var i = 0
        for char in mask {
            if char != "#" { // verificar se a string e um numero #
                if isDeleting {
                    continue
                }
                
                result = result + String(char)
            } else {
                let character = str.charAtIndex(index: i) // se for ele chama o index
                guard let c = character else {break}
                
                result = result + String(c)
                i = i + 1
                
            }
        }
        
        return result
    }
}
