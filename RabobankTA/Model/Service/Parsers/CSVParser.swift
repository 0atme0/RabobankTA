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
        
//        String should've had at least two characters
        if string.count < 2 {
            return []
        }
        
//        Temp variables
        var columns: [String] = []
        var column: String = ""
        var index: String.Index = string.startIndex
        let maxIndex: String.Index = string.index(before: string.endIndex)
        var inQuotes: Bool = false
        var result: [[String]] = []
        
//        Run through the string to check if it has quotes and ends of the lines
        while index < string.endIndex {
            
//            Check if we are currently in quotes
            if inQuotes {
                
//                If we found a quote then look ahead for another
                if (string[index] == "\"") {
                    
//                    If we found another quote -> it escaped
//                    Then increment the index and add it to column
                    if index < maxIndex && string[string.index(after: index)] == "\"" {
                        string.formIndex(after: &index)
                        column += String(string[index])
                    } else {
                        
//                        Otherwise next character is not a quote
//                        Last quote is not escaped
//                        Then toggle inQuotes
                        inQuotes = !inQuotes
                    }
                } else {
                    
//                    If it is not a quote -> add character to the column
                    column += String(string[index])
                }
                
//                If we are not in quotes then we can look for the ends of the lines and separators
            } else {
                
//                If we found a quote -> toggle inQuotes
                if string[index] == "\"" {
                    inQuotes = !inQuotes
                    
//                    If we found End Of Line characters -> reqched the end of the line and our column and row is complete
                } else if string[index] == "\r" || string[index] == "\r\n" || string[index] == "\n" {
                    columns.append(column)
                    result.append(columns)
                    columns = []
                    column = ""
                    
//                    If we found the separator -> column is complete -> add it to columns
                } else if string[index] == separator {
                    columns.append(column)
                    column = ""
                    
//                    Otherwise add the character to the column
                } else {
                    column += String(string[index])
                }
            }
            
//            If the current index is equal to maxIndex -> add the last column to columns and add columns to the result
            if index == maxIndex {
                if column.count > 0 || string[string.index(before: index)] == separator {
                    columns.append(column)
                }
                if columns.count > 0 {
                    result.append(columns)
                }
                break
            }
            
//            Increment the index at the end
            string.formIndex(after: &index)
        }
        return result
    }
}
