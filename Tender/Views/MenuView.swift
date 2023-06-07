//
//  MenuView.swift
//  Tender
//
//  Created by Norman Mukhallish on 04/06/23.
//

import SwiftUI

struct MenuView: View {
    @Namespace var namespace
    @State private var menuNameList = MenuList.menuList()
    @State private var isConnectedView: Bool = false
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    
                    Text("Hi, ") +
                    Text("John").fontWeight(.bold)
                    
                    Image("profilPic")
                }.frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                    .padding(.top, 50)
                    .frame(maxHeight: .infinity)
                
                Image("logo")
                    .padding(50)
                Button(action:{
                    
                }){
                    Text("DISCOVER")
                        .font(.title)
                        .padding()
                        .frame(width: 400)
                        .frame(height: 195)
                        .background(Color("purpleColor"))
                        .foregroundColor(Color("whiteColor"))
                }

                
                Button(action:{
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        isConnectedView.toggle()
                    }
                }){
                    MenuItem(namespace: namespace, title: "CONNECTED", isHeader: false, isConnectedView: $isConnectedView)
                }.offset(y:-8)
                Button(action:{
                    
                }){
                    Text("NOTIFICATION")
                        .font(.title)
                        .padding()
                        .frame(width: 400)
                        .frame(height: 195)
                        .background(Color("orangeColor"))
                        .foregroundColor(Color("whiteColor"))
                }.offset(y:-16)
                
            }
            .background(Color("whiteColor"))
            if isConnectedView {
                ConnectedView(namespace: namespace, isConnectedView: $isConnectedView)
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
