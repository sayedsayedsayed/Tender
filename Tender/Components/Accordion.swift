//
//  Accordion.swift
//  Tender
//
//  Created by Agfid Prasetyo on 07/06/23.
//

import SwiftUI

struct Accordion: View {
    @State private var expand: Bool = false
    var title: String = ""
    var content: AnyView
    var body: some View {
        VStack {
            DisclosureGroup(isExpanded: $expand) {
                HStack {
                    VStack(alignment: .leading) {
                        content
                    }
                    Spacer()
                }
            } label: {
                Text(title).bold().foregroundColor(Color("purpleColor"))
            }
            .padding(.horizontal)
            .foregroundColor(Color.black)
        }
    }
}

//struct Accordion_Previews: PreviewProvider {
//    static var previews: some View {
//        Accordion(title: "text", data: SkillsViewModel().skills, content: () -> any View)
//    }
//}
