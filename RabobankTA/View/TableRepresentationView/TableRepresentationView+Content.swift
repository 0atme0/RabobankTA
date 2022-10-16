//
//  TableRepresentationView+Content.swift
//  RabobankTA
//
//  Created by atme on 12/10/2022.
//

import SwiftUI

extension TableRepresentationView {
    var content: some View {
        VStack(spacing: 0) {
            if viewModel.table?.withHeader ?? true {
                HStack(spacing: 1) {
                    ForEach(viewModel.table?.columnsInHeader?.values ?? [], id: \.self) { item in
                        HeaderView(text: item)
                    }
                }
                .padding(.top)
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(zip((viewModel.table?.keyedRows ?? []).indices, viewModel.table?.keyedRows ?? [])), id: \.0) { index, row in
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
}
