//
//  CSVParser.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

class CSVParser: ParserProtocol {
    
    /// method parses file and return the table
    /// - Parameter url: path to file
    /// - Returns: a table entity
    func parseFile(_ url: URL) async throws -> TableEntity {
        var resultValue = [[String]]()
        let data = try Data(contentsOf: url)
        let str = String(decoding: data, as: UTF8.self)
        resultValue = self.parseCsv(str)
        return TableEntity(rows: resultValue.map{RowEntity(values: $0)})
    }
    
    /// method parses csv string into array of lines
    /// - Parameters:
    ///   - string: file content
    ///   - separator: which csv separator you use in the file
    /// - Returns: array of lines
    func parseCsv(_ string: String, separator: Character = ",") -> [[String]] {
        if string.count < 2 {
            return []
        }
        var columns: [String] = []
        var column: String = ""
        var index: String.Index = string.startIndex
        let maxIndex: String.Index = string.index(before: string.endIndex)
        var inQuotes: Bool = false
        var result: [[String]] = []
        
//        Run through the string by index to check if it has quotes, ends of the lines and separators
//        There are two different logic
//        1) if we are in quotes
//        we adding the values to column before we escape the quotes
//        2) if we are not
//        we implement the rest of the logic to split by lines, columns and detecting opening quotes
        while index < string.endIndex {
            if inQuotes {
                if (string[index] == "\"") {
                    if index < maxIndex && string[string.index(after: index)] == "\"" {
                        string.formIndex(after: &index)
                        column += String(string[index])
                    } else {
                        inQuotes = !inQuotes
                    }
                } else {
                    column += String(string[index])
                }
            } else {
                if string[index] == "\"" {
                    inQuotes = !inQuotes
                } else if string[index] == "\r" || string[index] == "\r\n" || string[index] == "\n" {
                    columns.append(column)
                    result.append(columns)
                    columns = []
                    column = ""
                } else if string[index] == separator {
                    columns.append(column)
                    column = ""
                } else {
                    column += String(string[index])
                }
            }
            if index == maxIndex {
                if column.count > 0 || string[string.index(before: index)] == separator {
                    columns.append(column)
                }
                if columns.count > 0 {
                    result.append(columns)
                }
                break
            }
            string.formIndex(after: &index)
        }
        return result
    }
}
