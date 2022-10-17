//
//  CSVTableView.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import SwiftUI

struct TableRepresentationView: View {
    @ObservedObject var viewModel: TableRepresentationViewModel
    @Binding var isPresented: TableEntity?
    var body: some View {
        NavigationView {
            content
                .toolbar {
                    Button("Done") {
                        isPresented = nil
                    }
                    .foregroundColor(.black)
                    .buttonStyle(.plain)
                }
        }
    }
}

struct TableRepresentationView_Previews: PreviewProvider {
    static var previews: some View {
        TableRepresentationView(viewModel: TableRepresentationViewModel(TableEntity(rows: [])), isPresented: .constant(nil))
    }
}
