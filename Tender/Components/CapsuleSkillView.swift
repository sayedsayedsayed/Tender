//
//  CapsuleSkillView.swift
//  Tender
//
//  Created by Ahmad Fadly Iksan on 09/06/23.
//

import SwiftUI

struct CapsuleSkillView: View {
    var skill: Skills
    var body: some View {
        HStack{
            if skill.image.isEmpty{
                Image(systemName: "square")
            }else{
                Image(skill.image)
            }
            Text(skill.name).foregroundColor(Color("purpleColor"))
        }
        .frame(height: 1)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color("purpleColor"), lineWidth:1)
        )
//        .border(Color("purpleColor"))
//        .cornerRadius(10)
    }
}

struct CapsuleSkillView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleSkillView(skill: Skills(image: "", name: "label"))
    }
}
