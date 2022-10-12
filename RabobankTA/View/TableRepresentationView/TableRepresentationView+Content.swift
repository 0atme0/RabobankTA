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
