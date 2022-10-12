//
//  CSVTableView.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import SwiftUI

struct TableRepresentationView: View {
    @ObservedObject var viewModel: TableRepresentationViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            content
                .toolbar {
                    Button("Done") {
                        dismiss()
                    }
                }
        }
    }
}

struct TableRepresentationView_Previews: PreviewProvider {
    static var previews: some View {
        TableRepresentationView(viewModel: TableRepresentationViewModel(TableEntity(rows: [])))
    }
}
