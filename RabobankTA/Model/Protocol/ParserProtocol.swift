//
//  ParserProtocol.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

typealias TableEntityResult = Result<TableEntity, Error>
typealias TableEntityResultCompletion = (TableEntityResult)->()

protocol ParserProtocol {
    func parseFile(_ url: URL, completion: @escaping TableEntityResultCompletion)
}
