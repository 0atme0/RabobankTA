//
//  CSVParser.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

class CSVParser: ParserProtocol {
    func parseFile(_ url: URL, completion: @escaping (TableEntity)->()) {
        print(#function)
        DispatchQueue.global(qos: .userInitiated).async {
            var resultValue = [[String]]()
            let data = try? Data(contentsOf: url)
            data?.withUnsafeBytes { $0
                .split(separator: UInt8(ascii: "\n"))
                .forEach { row in
                    let columns = row.withUnsafeBytes { $0.split(separator: UInt8(ascii: ",")).map { String(decoding: UnsafeRawBufferPointer(rebasing: $0), as: UTF8.self) }}
                    resultValue.append(columns)
                }}
            DispatchQueue.main.async {
                completion(TableEntity(rows: resultValue.map{RowEntity(values: $0)}))
            }
        }
    }
}
