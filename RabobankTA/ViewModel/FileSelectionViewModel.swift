//
//  FileSelectionViewModel.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

class FileSelectionViewModel: ObservableObject {
    
    @Published var fileList: [URL] = []
    @Published var error: String?
    @Published var currentTable: TableEntity?
    @Published var isLoading: URL?
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
        //otherwise
        self.parser.parseFile(url) { [weak self] result in
            switch result {
            case .success(let table):
                self?.cache[url] = table
                completion(table)
            case .failure(let error):
                self?.error = error.localizedDescription
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self?.error = nil
                }
            }
        }
    }
    
}
