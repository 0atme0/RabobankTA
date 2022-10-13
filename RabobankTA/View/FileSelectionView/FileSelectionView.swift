//
//  FileSelectionView.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import SwiftUI

struct FileSelectionView: View {
    @ObservedObject var viewModel: FileSelectionViewModel
    var body: some View {
        content
            .overlay(alignment: .bottom) {
                if let error = viewModel.error {
                    Text("Error: \(error)")
                        .foregroundColor(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.black))
                }
            }
            .fullScreenCover(item: $viewModel.currentTable) { table in
                TableRepresentationView(viewModel: TableRepresentationViewModel(table), isPresented: $viewModel.currentTable)
            }
    }
}

struct FileSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        FileSelectionView(viewModel: FileSelectionViewModel())
    }
}
