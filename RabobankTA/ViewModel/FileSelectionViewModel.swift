//
//  FileSelectionViewModel.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

class FileSelectionViewModel: ObservableObject {
    
    @Published var fileList: [URL] = []
    private var storage: StorageProtocol
    private var parser: CSVParserProtocol

    init(storage: StorageProtocol = Storage(), parser: CSVParserProtocol = CSVParser()) {
        self.storage = storage
        self.parser = parser
        
        fetchFileList()
    }
    
    //MARK: -Public methods
    func openFile(_ file: URL) {
        guard let content = try? String(contentsOf: file) else {return}
        parser.parseString(content) { tableValue in
            print(tableValue)
        }

    }
    
    //MARK: -Private methods
    private func fetchFileList() {
        self.fileList = storage.getFileList()
    }
    
}
