//
//  CSVTableView.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import SwiftUI

struct CSVTableView: View {
    @ObservedObject var viewModel: CSVTableViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CSVTableView_Previews: PreviewProvider {
    static var previews: some View {
        CSVTableView(viewModel: CSVTableViewModel())
    }
}
