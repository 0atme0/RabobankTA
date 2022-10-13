//
//  TableRepresentationView+Content.swift
//  RabobankTA
//
//  Created by atme on 12/10/2022.
//

import SwiftUI

extension TableRepresentationView {
    var content: some View {
        ScrollView {
            LazyVStack {
                if viewModel.table?.withHeader ?? true {
                    HStack(spacing: 1) {
                        ForEach(viewModel.table?.columnsInHeader?.values ?? [], id: \.self) { item in
                            HeaderView(text: item)
                        }
                    }
                ForEach(viewModel.table?.keyedRows ?? [], id: \.self) { row in
                    HStack(spacing: 1) {
                        ForEach(viewModel.table?.columnsInHeader?.values ?? [], id: \.self) { item in
                            RowView(text: row[item])
                        }
                    }
                }
                }
            }
        }
    }
}
