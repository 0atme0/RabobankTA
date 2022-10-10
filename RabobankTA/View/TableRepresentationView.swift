//
//  CSVTableView.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import SwiftUI

struct TableRepresentationView: View {
    @ObservedObject var viewModel: TableRepresentationViewModel
    private let currencyStyle = Decimal.FormatStyle.Currency(code:"USD")
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(zip(viewModel.table!.columnsInHeader.values.indices, viewModel.table!.columnsInHeader.values)), id: \.0) { index, column in
                List {
                    Section(header:
                                Text(column)
                        .frame(height: 60)
                    ) {
                        ForEach(viewModel.table!.rowsWOHeader, id: \.id) { item in
                            Text(item.values[index])
                                .frame(height: 60)
                                .font(.system(size: 8))
                        }
                    }.listStyle(GroupedListStyle())
                        .disabled(true)
                }
            }
        }
    }
}

struct TableRepresentationView_Previews: PreviewProvider {
    static var previews: some View {
        TableRepresentationView(viewModel: TableRepresentationViewModel(fileURL: URL(string: "")!))
    }
}

