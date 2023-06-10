//
//  ListFreelancer.swift
//  Tender
//
//  Created by Agfid Prasetyo on 05/06/23.
//

import SwiftUI

struct ListFreelancer: View {
    var freelancers: [FreelancerDummyModel]
    @Binding var selectedFreelancer: FreelancerDummyModel
    @Binding var isNavigate: Bool
    var onTap: () -> Void
    @State private var totalHeight = CGFloat.zero       // << variant for ScrollView/List
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
            ForEach(self.freelancers, id: \.self) { freelancer in
//                AnyView {
                    ConnectedCard(freelancer: freelancer)
                    .padding(.init(top: 15, leading: 10, bottom: 15, trailing: 10))
                        .alignmentGuide(.leading, computeValue: { d in
                            if (abs(width - d.width) > g.size.width)
                            {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if freelancer == self.freelancers.last! {
                                width = 0 //last item
                            } else {
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: {d in
                            let result = height
                            if freelancer == self.freelancers.last! {
                                height = 0 // last item
                            }
                            return result
                        })
                        .onTapGesture {
                            selectedFreelancer = freelancer
                            onTap()
                            isNavigate = true
                        }.navigationDestination(isPresented: $isNavigate, destination: {
//                            LoginView()
                        })
                    
//                }.padding(.horizontal, 10)
            }
        }.background(viewHeightReader($totalHeight)).padding(.horizontal, 10)
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

struct ListFreelancer_Previews: PreviewProvider {
    static var previews: some View {
        ListFreelancer(freelancers: [], selectedFreelancer: .constant(FreelancerViewModel().freelancer.first!), isNavigate: .constant(false), onTap: {})
    }
}
