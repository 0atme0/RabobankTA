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
    private func handleError(_ errorText: String) {
        self.error = errorText
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.error = nil
        }
    }
    private func openFile(_ url: URL) async -> TableEntity? {
        //check cache
        if let table = cache[url] {
            return table
        }
        //otherwise
        if let table = try? await self.parser.parseFile(url) {
            self.cache[url] = table
            return table
        } else {
            self.handleError(Error.failedToParse)
        }
        return nil
    }
    
    //MARK: -Public methods
    func tapOnFile(_ url: URL) {
        Task {
            await MainActor.run {
                self.isLoading = url
            }
            let table = await self.openFile(url)
            await MainActor.run {
                self.isLoading = nil
                self.currentTable = table
            }
        }
    }
}
