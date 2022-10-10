//
//  Storage.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

protocol StorageProtocol {
    func getFileList() -> [URL]
}

class Storage: StorageProtocol {
    func getFileList() -> [URL] {
        Bundle.main.urls(forResourcesWithExtension: "csv", subdirectory: nil) ?? []
    }
}
