//
//  FileSelectionViewModel.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

class FileSelectionViewModel: ObservableObject {
    
    @Published var fileList: [URL] = []
    var cache = [URL: TableEntity]()
    private var storage: StorageProtocol
    private var parser: ParserProtocol
    
    init(storage: StorageProtocol = Storage(), parser: ParserProtocol = ParserFactory.getParser(.csv)) {
        self.storage = storage
        self.parser = parser
        fetchFileList()
    }
    
    //MARK: -Private methods
    private func fetchFileList() {
        self.fileList = storage.getFileList()
    }
    
    //MARK: -Public methods
    func openFile(_ url: URL, completion: @escaping (TableEntity)->()) {
        //check cache
        if let table = cache[url] {
            completion(table)
            return
        }
        self.parser.parseFile(url) { [weak self] table in
            self?.cache[url] = table
            completion(table)
        }
    }
    
}
