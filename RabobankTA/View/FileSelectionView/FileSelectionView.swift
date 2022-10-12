//
//  FileSelectionView.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import SwiftUI

struct FileSelectionView: View {
    @ObservedObject var viewModel: FileSelectionViewModel
    @State private var currentTable: TableEntity?
    @State var isLoading: URL?
    var body: some View {
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
                        HStack {
                            Label(element.lastPathComponent, systemImage: "filemenu.and.selection")
                            if isLoading == element {
                                ProgressView()
                                    .padding(.horizontal)
                            }
                        }
                        .padding()
                        .clipShape(Rectangle())
                        .onTapGesture {
                            isLoading = element
                            viewModel.openFile(element) { table in
                                self.isLoading = nil
                                self.currentTable = table
                            }
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
            }
        }
        .fullScreenCover(item: $currentTable) { table in
            TableRepresentationView(viewModel: TableRepresentationViewModel(table))
        }
    }
}

struct FileSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        FileSelectionView(viewModel: FileSelectionViewModel())
    }
}
