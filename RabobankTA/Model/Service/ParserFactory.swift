//
//  ParserFactory.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

class ParserFactory {
    class func getParser(_ type: FileType) -> ParserProtocol {
        switch type {
        case .scv:
            return CSVParser()
        }
    }
}
