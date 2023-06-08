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
    @Binding var isFromMenu: Bool
    @State var header: Bool = true

    var body: some View {
        print(isHeader)
        return
        ZStack {
            if isHeader || !isFromMenu {
//                VStack {
                    ZStack {
//                        if isFromMenu {
                            Rectangle()
                                .foregroundColor(color)
                                .matchedGeometryEffect(id: "rectangle", in: namespace, isSource: true)
                                .frame(height: 150)
                                .offset(y: 0)
//                        } else {
//                            Rectangle()
//                                .foregroundColor(color)
//                                .matchedGeometryEffect(id: "rectangle", in: namespace, anchor: UnitPoint(x: 0.5, y: 3.4))
//                                .frame(height: 150)
//                                .offset(y: 0)
//                        }
                        ZStack {
                            VStack(spacing: 5) {
                                Image(systemName: "chevron.compact.down")
                                    .resizable()
                                    .padding(.top, 11)
                                    .font(Font.system(.title2)).foregroundColor(Color.white).frame(width: 50, height: 20)
                                    .onTapGesture {
                                        withAnimation() {
                                            activeScreen = .menu
                                            isFromMenu = true
                                        }
                                    }
                                HStack {
//                                    if isFromMenu {
                                        HStack {
                                            Text(title)
                                                .font(.title2)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color.white)
                                                .matchedGeometryEffect(id: "title", in: namespace)
                                            Spacer()
                                        }

//                                    } else {
//                                        HStack {
//                                            Text(title)
//                                                .font(.title2)
//                                                .fontWeight(.semibold)
//                                                .foregroundColor(Color.white)
//                                                .matchedGeometryEffect(id: "title", in: namespace, anchor: UnitPoint(x: 5, y: 16.5))
//                                            Spacer()
//                                        }.frame(maxWidth: .infinity)
//
//                                    }
//                                    Text(title)
//                                        .font(.title2)
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(Color.white)
//                                        .matchedGeometryEffect(id: "title", in: namespace, anchor: .bottom)
                                    Spacer()
                                }.padding(.init(top: 5, leading: 20, bottom: -20, trailing: 20))
                            }.padding(.bottom, 5)
                        }.padding(.top, 10)
                    }.offset(y: 0)
//                    .frame(width: 350, height: 600)
                
//                }
            } else {
                ZStack {
                    Rectangle()
                        .foregroundColor(color)
                        .matchedGeometryEffect(id: "rectangle", in: namespace)
                        .frame(height: 160)
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
        MenuItem(namespace: namespace, title: "kontol", color: Color("pinkColor"), isHeader: true, activeScreen: .constant(.connected), isFromMenu: .constant(true))
    }
}
