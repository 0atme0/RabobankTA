//
//  StorageProtocol.swift
//  RabobankTA
//
//  Created by atme on 16/10/2022.
//

import Foundation

protocol StorageProtocol {
    func getFileList() -> [URL]
}
