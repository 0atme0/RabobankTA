//
//  CSVParser.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

class CSVParser: ParserProtocol {
    func parseFile(_ url: URL,  completion: @escaping TableEntityResultCompletion) {
        DispatchQueue.global(qos: .userInitiated).async {
            var resultValue = [[String]]()
            
            guard let data = try? Data(contentsOf: url) else {return}
            let str = String(decoding: data, as: UTF8.self)
            resultValue = self.parseCsv(str)
            DispatchQueue.main.async {
                completion(.success(TableEntity(rows: resultValue.map{RowEntity(values: $0)})))
            }
        }
    }
    func parseCsv(_ string: String, separator: Character = ",") -> [[String]] {
        if string.count < 2 {
            return []
        }
        var columns: [String] = []
        var index: String.Index = string.startIndex
        let maxIndex: String.Index = string.index(before: string.endIndex)
        var inQuotes: Bool = false
        var result: [[String]] = []
        var column: String = ""
        while index < string.endIndex {
            if inQuotes { // In quotes.
                if (string[index] == "\"") {
                    // Found quote; look ahead for another.
                    if index < maxIndex && string[string.index(after: index)] == "\"" {
                        // Found another quote means escaped.
                        // Increment and add to column value.
                        string.formIndex(after: &index)
                        column += String(string[index])
                    } else {
                        // Next character not a quote; last quote not escaped.
                        inQuotes = !inQuotes // Toggle "Are we in quotes?"
                    }
                } else {
                    // Add character to column value.
                    column += String(string[index])
                }
            } else { // Not in quotes.
                if string[index] == "\"" {
                    // Found quote.
                    inQuotes = !inQuotes // Toggle "Are we in quotes?"
                } else if string[index] == "\r" || string[index] == "\r\n" || string[index] == "\n" {
                    // Reached end of line.
                    // Column and row complete.
                    columns.append(column)
                    column = ""
                    result.append(columns)
                    columns = []
                } else if string[index] == separator {
                    // Found comma; column complete.
                    columns.append(column)
                    column = ""
                } else {
                    // Add character to column value.
                    column += String(string[index])
                }
            }
            if index == maxIndex {
                // Reached end of data; flush.
                if column.count > 0 || string[string.index(before: index)] == separator {
                    columns.append(column)
                }
                if columns.count > 0 {
                    result.append(columns)
                }
                break
            }
            string.formIndex(after: &index) // Increment.
        }
        return result
    }
}
