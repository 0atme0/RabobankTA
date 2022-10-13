//
//  TableEntity.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import SwiftUI

struct RowEntity: Identifiable, Hashable {
    var id = UUID()
    var values: [String] = []
}

class TableEntity: ObservableObject, Identifiable {
    
    @Published var rows: [RowEntity]
    @Published var columnsInHeader: RowEntity?
    @Published var rowsWOHeader: [RowEntity] = []
    @Published var keyedRows: [[String: String]]?
    var withHeader = true
    
    init(rows: [RowEntity], withHeader: Bool = true, headers: RowEntity? = nil) {
        self.rows = rows
        self.withHeader = withHeader
        if withHeader {
            if rows.count > 0 {
                self.columnsInHeader = headers ?? rows.first
                self.rowsWOHeader = Array(rows.suffix(rows.count - 1))
                keyedRows = rowsWOHeader.map { fields -> [String: String] in
                    var row = [String: String]()
                    for (index, value) in fields.values.enumerated() where value.isNotEmptyOrWhitespace {
                        if let values = columnsInHeader?.values, index < values.count {
                            row[values[index]] = value
                        }
                    }
                    return row
                }
            }
        } else {
            rowsWOHeader = rows
        }
    }
}
