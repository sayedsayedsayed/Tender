//
//  WrappedHStack.swift
//  Tender
//
//  Created by Agfid Prasetyo on 05/06/23.
//

import SwiftUI

struct ListSkills: View {
    var skills: [Skills]

    @State private var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.skills, id: \.self) { skill in
                self.item(for: skill.name)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if skill == self.skills.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if skill == self.skills.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String) -> some View {
        HStack {
            Text(text)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(Color("purpleColor"))
                .padding(.vertical, 2.0)
        }
        .padding(.horizontal, 5.0)
        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("purpleColor"), lineWidth: 1))
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}



struct ListSkills_Previews: PreviewProvider {
    static var previews: some View {
        ListSkills(skills: [])
    }
}
