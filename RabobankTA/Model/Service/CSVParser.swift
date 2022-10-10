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
        let rows = value.split(separator: "\r\n", omittingEmptySubsequences: true)
        
        for (index, row) in rows.enumerated() {
            print(index, row)
            let columns = row.split(separator: ",", omittingEmptySubsequences: true)
            let columnsArray = columns.map{String($0)}
            resultValue.append(columnsArray)
        }
        completion(TableEntity(rows: resultValue.map{RowEntity(values: $0)}))
    }
}
