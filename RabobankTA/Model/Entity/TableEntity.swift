//
//  TableEntity.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

struct TableEntity {
    var lines: [[String]]
    
    //MARK: Calculated values
    var columnsInHeader: Int {
        (lines.first ?? []).count
    }
}
