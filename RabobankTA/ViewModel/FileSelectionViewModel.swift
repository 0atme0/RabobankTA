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

    init(storage: StorageProtocol = Storage()) {
        self.storage = storage
        fetchFileList()
    }
    
    //MARK: -Private methods
    private func fetchFileList() {
        self.fileList = storage.getFileList()
    }
    
}
