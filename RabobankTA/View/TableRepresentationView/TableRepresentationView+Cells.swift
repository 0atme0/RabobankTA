//
//  TableRepresentationView+Cells.swift
//  RabobankTA
//
//  Created by atme on 10/10/2022.
//

import SwiftUI

extension TableRepresentationView {
    struct HeaderView: View {
        @State var text: String
        var body: some View {
            VStack {
                Text(text)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 80)
            .background(Color.green)
            
        }
    }
    struct RowView: View {
        @State var text: String
        var body: some View {
            VStack {
                Text(text)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 80)
        }
    }
}
