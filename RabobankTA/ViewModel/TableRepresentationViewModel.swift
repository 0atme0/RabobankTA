//
//  CSVTableViewModel.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

class CSVTableViewModel: ObservableObject {
    
    @Published var table: TableEntity?
    private var parser: ParserProtocol

    init(fileURL: URL, parser: ParserProtocol = ParserFactory.getParser(.scv)) {
        self.parser = parser
        openFile(fileURL)
    }
    
    //MARK: -Private methods
    private func openFile(_ file: URL) {
        guard let content = try? String(contentsOf: file) else {return}
        parser.parseString(content) { tableValue in
            self.table = tableValue
        }
    }
}
