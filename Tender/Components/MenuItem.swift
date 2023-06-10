//
//  MenuItem.swift
//  Tender
//
//  Created by Agfid Prasetyo on 07/06/23.
//

import SwiftUI

struct MenuItem: View {
    var namespace: Namespace.ID
    var title: String = "TITLE"
    var color: Color = Color("pinkColor")
    var isHeader: Bool = true
    @Binding var activeScreen: Show
    @State var header: Bool = true

    var body: some View {
        ZStack {
            if isHeader {
                    ZStack {
                            Rectangle()
                                .foregroundColor(color)
                                .matchedGeometryEffect(id: "rectangle", in: namespace, isSource: true)
                                .frame(height: 150)
                                .offset(y: 0)
                        ZStack {
                            VStack(spacing: 5) {
                                Image(systemName: "chevron.compact.down")
                                    .resizable()
                                    .padding(.top, 11)
                                    .font(Font.system(.title2)).foregroundColor(Color.white).frame(width: 50, height: 20)
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 1)) {
                                            activeScreen = .menu
                                        }
                                    }
                                HStack {
                                        HStack {
                                            Text(title)
                                                .font(.title2)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color.white)
                                                .matchedGeometryEffect(id: "title", in: namespace)
                                            Spacer()
                                        }
                                    Spacer()
                                }.padding(.init(top: 5, leading: 20, bottom: -20, trailing: 20))
                            }.padding(.bottom, 5)
                        }.padding(.top, 10)
                    }.offset(y: 0)
                
            } else {
                ZStack {
                    Rectangle()
                        .foregroundColor(color)
                        .matchedGeometryEffect(id: "rectangle", in: namespace)
                        .frame(height: 180)
                    ZStack {
                        VStack(spacing: 5) {
                            HStack {
                                Text(title)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .matchedGeometryEffect(id: "title", in: namespace)
                            }.padding()
                        }.padding(.bottom, 5)
                    }.padding(.top, 10)
                }
            }
            
        }
    }
}

struct MenuItem_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        MenuItem(namespace: namespace, title: "kontol", color: Color("pinkColor"), isHeader: true, activeScreen: .constant(.connected))
    }
}
