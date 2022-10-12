//
//  String+Whitespace.swift
//  RabobankTA
//
//  Created by atme on 12/10/2022.
//

import Foundation

extension String {

    var isEmptyOrWhitespace: Bool {
        return isEmpty || trimmingCharacters(in: .whitespaces) == ""
    }

    var isNotEmptyOrWhitespace: Bool {
        return !isEmptyOrWhitespace
    }

}
