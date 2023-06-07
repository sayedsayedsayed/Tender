//
//  SearchBar.swift
//  Tender
//
//  Created by Agfid Prasetyo on 06/06/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var search: String
    @Binding var isSearch: Bool
    var body: some View {
        HStack(spacing: 10) {
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                TextField("Search", text: $search)
                    .font(Font.system(.body))
                    .padding(.vertical, 10)
            }
            .ignoresSafeArea()
            .padding(.horizontal, 10)
            .background(Color.white)
            .cornerRadius(5)
            Text("Cancel").padding(.trailing, 10).foregroundColor(Color.blue).onTapGesture {
                isSearch.toggle()
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(search: .constant(""), isSearch: .constant(false))
    }
}
