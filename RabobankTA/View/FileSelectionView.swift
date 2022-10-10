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
        VStack {
            Text("Rabobank Tech Assignment")
                .font(.title)
            Menu {
                ForEach(viewModel.fileList, id: \.self) { element in
                    Button(element.lastPathComponent) {
                        openFile(element)
                    }
                }
            } label: {
                Label("Choose a CSV file to open", systemImage: "filemenu.and.cursorarrow")
            }
        }
    }
    func openFile(_ file: URL) { }
}

struct FileSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        FileSelectionView(viewModel: FileSelectionViewModel(storage: Storage()))
    }
}
