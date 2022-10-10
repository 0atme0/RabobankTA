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
        ScrollView {
            VStack {
                HStack(spacing: 1) {
                    ForEach(viewModel.table?.columnsInHeader.values ?? [], id: \.self) { item in
                        HeaderView(text: item)
                    }
                }
                ForEach(viewModel.table?.rowsWOHeader ?? [], id: \.id) { row in
                    HStack(spacing: 1) {
                        ForEach(row.values, id: \.self) { item in
                            RowView(text: item)
                        }
                    }
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
