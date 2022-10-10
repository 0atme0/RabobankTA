//
//  CSVParser.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

class CSVParser: ParserProtocol {
    func parseString(_ value: String, completion: (TableEntity)->()) {
        var resultValue = [[String]]()
        let lines = value.split(separator: "\r\n", omittingEmptySubsequences: true)
        
        for (index, line) in lines.enumerated() {
            print(index, line)
            let columns = line.split(separator: ",", omittingEmptySubsequences: true)
            let columnsArray = columns.map{String($0)}
            resultValue.append(columnsArray)
        }
        completion(TableEntity(lines: resultValue))
    }
}
