//
//  ParserProtocol.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

protocol ParserProtocol {
    func parseString(_ value: String, completion: (TableEntity)->())
}
