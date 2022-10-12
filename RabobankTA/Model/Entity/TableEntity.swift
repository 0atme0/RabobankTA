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
    @Published var columnsInHeader: RowEntity
    @Published var rowsWOHeader: [RowEntity] = []
    
    init(rows: [RowEntity]) {
        self.rows = rows
        self.columnsInHeader = rows.first ?? RowEntity()
        if rows.count > 0 {
            self.rowsWOHeader = Array(rows.suffix(rows.count - 1))
        }
    }
}
