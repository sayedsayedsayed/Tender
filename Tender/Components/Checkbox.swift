//
//  Checkbox.swift
//  Tender
//
//  Created by Agfid Prasetyo on 07/06/23.
//

import SwiftUI

struct Checkbox: View {
    @State var isChecked: Bool = false
    var label: String = "Label"
    var onTap: () -> Void
    var body: some View {
        Button(action: {

            // 2
            isChecked.toggle()
            onTap()

        }, label: {
            HStack {
                // 3
                Image(systemName: isChecked ? "checkmark.square" : "square")

                Text(label)
            }
        })
    }
}

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        Checkbox(onTap: {})
    }
}
