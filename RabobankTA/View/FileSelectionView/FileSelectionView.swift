//
//  FileSelectionView.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import SwiftUI

struct FileSelectionView: View {
    @ObservedObject var viewModel: FileSelectionViewModel
    @State private var isNavigationActive = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Menu {
                    ForEach(viewModel.fileList, id: \.self) { element in
                        NavigationLink(element.lastPathComponent, value: element)
                    }
                } label: {
                    Label("Choose a CSV file to open", systemImage: "filemenu.and.cursorarrow")
                }
                .navigationBarTitle("Rabobank Tech Assignment")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: URL.self) { url in
                    TableRepresentationView(viewModel: TableRepresentationViewModel(fileURL: url))
                }

            }
        }
    }
}

struct FileSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        FileSelectionView(viewModel: FileSelectionViewModel())
    }
}
