//
//  ParserFactory.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

class ParserFactory {
    
    /// method create the parser relates to the type
    /// - Parameter type: a parser type
    /// - Returns: the parser
    class func getParser(_ type: FileType) -> ParserProtocol {
        switch type {
        case .csv:
            return CSVParser()
        }
    }
}
