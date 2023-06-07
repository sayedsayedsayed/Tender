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
    var isHeader: Bool = false
    @Binding var isConnectedView: Bool
    
    var body: some View {
        ZStack {
            if isHeader {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("pinkColor"))
                        .matchedGeometryEffect(id: "rectangle", in: namespace)
                        .frame(height: 150)
                    ZStack {
                        VStack(spacing: 5) {
                            Image(systemName: "chevron.compact.down")
                                .resizable()
                                .font(Font.system(.title2)).foregroundColor(Color.white).frame(width: 50, height: 10)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        isConnectedView.toggle()
                                    }
                                }
                            HStack {
                                Text("CONNECTED")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .matchedGeometryEffect(id: "title", in: namespace)
                                Spacer()
                            }.padding(.init(top: 5, leading: 20, bottom: -20, trailing: 20))
                        }.padding(.bottom, 5)
                    }.padding(.top, 10)
                }
            } else {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("pinkColor"))
                        .matchedGeometryEffect(id: "rectangle", in: namespace)
                        .frame(height: 195)
                    ZStack {
                        VStack(spacing: 5) {
                            HStack {
                                Text("CONNECTED")
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
        MenuItem(namespace: namespace, title: "CONNECTED", isHeader: false, isConnectedView: .constant(false))
    }
}
