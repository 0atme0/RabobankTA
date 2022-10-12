//
//  CSVTableViewModel.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

class TableRepresentationViewModel: ObservableObject {
    
    @Published var table: TableEntity?
    
    init(_ table: TableEntity?) {
        self.table = table
    }
}
