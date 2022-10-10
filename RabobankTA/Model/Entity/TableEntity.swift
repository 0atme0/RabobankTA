//
//  TableEntity.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

struct RowEntity: Identifiable, Hashable {
    var id = UUID()
    var values: [String] = []
}

struct TableEntity {
    
    var rows: [RowEntity]
    var columnsInHeader: RowEntity
    var rowsWOHeader: [RowEntity]
    
    init(rows: [RowEntity]) {
        self.rows = rows
        self.columnsInHeader = rows.first ?? RowEntity()
        self.rowsWOHeader = Array(rows.suffix(rows.count - 1))
    }
}
