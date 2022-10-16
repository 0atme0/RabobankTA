//
//  Storage.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import Foundation

class Storage: StorageProtocol {
    
    /// method returns all csv files
    /// - Returns: array of csv files pathes
    func getFileList() -> [URL] {
        Bundle.main.urls(forResourcesWithExtension: "csv", subdirectory: nil) ?? []
    }
}
