//
//  String+Quotes.swift
//  RabobankTA
//
//  Created by atme on 12/10/2022.
//

import Foundation

extension String {
    
    func removeQuotes() -> String {
        guard self.count > 0 else {return self}
        
        var result = self
        if result.prefix(1) == "\"" {
            result = String(result.dropFirst(1))
        }
        if result.suffix(1) == "\"" {
            result = String(result.dropLast(1))
        }
        return result
    }
    
}
