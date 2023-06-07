//
//  TextFieldStyleCustom.swift
//  Tender
//
//  Created by Ahmad Fadly Iksan on 05/06/23.
//

import Foundation
import SwiftUI

struct TextFieldStyleCustom: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundColor(Color("purpleColor"))
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("purpleColor"), lineWidth:1)
            )
    }
}
