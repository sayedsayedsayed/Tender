//
//  SwiftUIView.swift
//  Tender
//
//  Created by Ahmad Fadly Iksan on 09/06/23.
//

import SwiftUI

struct FormTitleWithIcon: View {
    var iconName: String = ""
    var textTitle: String = "label"
    var body: some View {
        HStack{
            if iconName.isEmpty {
                Image(systemName: "square")
            }else {
                Image(iconName)
            }
            Text(textTitle.capitalized)
                .foregroundColor(Color("purpleColor"))
        }.frame(width: 350, height: 36.6, alignment: .leading)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FormTitleWithIcon()
    }
}
