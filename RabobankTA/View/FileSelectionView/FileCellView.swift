//
//  FileCellView.swift
//  RabobankTA
//
//  Created by atme on 17/10/2022.
//

import SwiftUI

struct FileCellView: View {
    @State var file: URL?
    @Binding var isLoadingURL: URL?
    var isLoading: Bool {
        file == isLoadingURL
    }
    var body: some View {
        HStack {
            Label(file?.lastPathComponent ?? "-", systemImage: "filemenu.and.selection")
            if isLoading {
                ProgressView()
                    .padding(.horizontal)
            }
        }
        .padding()
        .clipShape(Rectangle())
    }
}

struct FileCellView_Previews: PreviewProvider {
    static var previews: some View {
        FileCellView(file: URL(string: ""), isLoadingURL: .constant(URL(string: "")))
    }
}
