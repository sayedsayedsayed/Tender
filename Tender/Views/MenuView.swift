//
//  MenuView.swift
//  Tender
//
//  Created by Norman Mukhallish on 04/06/23.
//

import SwiftUI

struct MenuView: View {
    @Namespace var connected
    @Namespace var discover
    @Namespace var notification
    @Namespace var profile
    @State private var menuNameList = MenuList.menuList()
    @State private var activeScreen: Show = .menu

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Image("logo")
                        .padding(50)
                }.padding(.vertical, 15)
                Button(action:{
                    
                }){
                    MenuItem(namespace: discover, title: "DISCOVER", color: Color("purpleColor"), isHeader: false, activeScreen: $activeScreen)
                }

                
                Button(action:{
                    withAnimation() {
                        activeScreen = .connected
                    }
                }){
                    MenuItem(namespace: connected, title: "CONNECTED", color: Color("pinkColor"), isHeader: false, activeScreen: $activeScreen)
                }
                Button(action:{
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        activeScreen = .notification
                    }

                }){
                    MenuItem(namespace: notification, title: "NOTIFICATION", color: Color("orangeColor"), isHeader: false, activeScreen: $activeScreen)
                }
                Button(action:{
                    
                }){
                    MenuItem(namespace: profile, title: "PROFILE", color: Color("yellowColor"), isHeader: false, activeScreen: $activeScreen)
                }
                
            }
            .frame(maxHeight: .infinity)
            .background(Color("whiteColor"))
            switch activeScreen {
            case .connected:
                ConnectedView(namespace: connected, activeScreen: $activeScreen)                    .transition(.move(edge: .bottom))
            case .notification:
                NotificationListView(activeScreen: $activeScreen, namespace: notification).transition(.move(edge: .bottom))
            default:
                EmptyView()
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
