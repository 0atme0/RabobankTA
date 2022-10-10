//
//  CSVParser.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

protocol CSVParserProtocol {
    func parseString(_ value: String, completion: (CSVTable)->())
}

class CSVParser: CSVParserProtocol {
    func parseString(_ value: String, completion: (CSVTable)->()) {
        var resultValue = [[String]]()
        let lines = value.split(separator: "\r\n", omittingEmptySubsequences: true)
        
        for (index, line) in lines.enumerated() {
            print(index, line)
            let columns = line.split(separator: ",", omittingEmptySubsequences: true)
            let columnsArray = columns.map{String($0)}
            resultValue.append(columnsArray)
        }
            completion(CSVTable(columns: resultValue))
    }
}
