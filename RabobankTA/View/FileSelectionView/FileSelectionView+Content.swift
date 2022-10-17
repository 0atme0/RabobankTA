//
//  FileSelectionView+Content.swift
//  RabobankTA
//
//  Created by atme on 12/10/2022.
//

import SwiftUI

extension FileSelectionView {
    var content: some View {
        VStack {
            Text("RABOBANK TECH ASSIGNMENT")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            Label("Choose a CSV file to open", systemImage: "filemenu.and.cursorarrow")
                .padding()
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.fileList, id: \.self) { element in
                        FileCellView(file: element, isLoadingURL: $viewModel.isLoading)
                            .onTapGesture {viewModel.tapOnFile(element)}
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
            }
        }
    }
}
