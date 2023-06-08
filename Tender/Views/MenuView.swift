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
    @State private var isFromMenu: Bool = true
    
    var safeArea : EdgeInsets
    var size : CGSize
    var body: some View {
        NavigationStack {
            
            ZStack {
                ScrollView(.vertical, showsIndicators: false){
                    ZStack {
                        VStack(spacing: 0) {
                            HStack {
                                LogoWork()
                            }
                            Button(action:{
                                withAnimation {
                                    activeScreen = .discover
                                    isFromMenu = true
                                }
                                
                            }){
                                MenuItem(namespace: discover, title: "DISCOVER", color: Color("purpleColor"), isHeader: false, activeScreen: $activeScreen, isFromMenu: $isFromMenu)
                            }
                            
                            
                            Button(action:{
                                withAnimation() {
                                    activeScreen = .connected
                                    isFromMenu = true
                                }
                            }){
                                MenuItem(namespace: connected, title: "CONNECTED", color: Color("pinkColor"), isHeader: false, activeScreen: $activeScreen, isFromMenu: $isFromMenu)
                            }
                            Button(action:{
                                withAnimation {
                                    activeScreen = .notification
                                    isFromMenu = true
                                }
                                
                            }){
                                MenuItem(namespace: notification, title: "NOTIFICATION", color: Color("orangeColor"), isHeader: false, activeScreen: $activeScreen, isFromMenu: $isFromMenu)
                            }
                            Button(action:{
                                
                            }){
                                MenuItem(namespace: profile, title: "PROFILE", color: Color("yellowColor"), isHeader: false, activeScreen: $activeScreen, isFromMenu: $isFromMenu)
                            }
                            
                        }
                        .frame(maxHeight: .infinity)
                        .background(Color("whiteColor"))
                    }
                }
                    .coordinateSpace(name: "SCROLL")
                    .edgesIgnoringSafeArea(.all)
                    .overlay {
                        switch activeScreen {
                        case .discover:
                            SwipeView(activeScreen: $activeScreen, isFromMenu: $isFromMenu, namespace: discover).transition(.move(edge: .bottom))
                        case .connected:
                            ConnectedView(namespace: connected, activeScreen: $activeScreen, isFromMenu: $isFromMenu).transition(.move(edge: .bottom))
                        case .notification:
                            NotificationListView(activeScreen: $activeScreen, namespace: notification, isFromMenu: $isFromMenu).transition(.move(edge: .bottom))
                        default:
                            EmptyView()
                        }

                    }
                                
            }
        }
    }
    
    @ViewBuilder
    func LogoWork()-> some View{
        let height =  size.height * 0.3
        GeometryReader{ proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            
            let progress = minY / (height)
            
            Image("logo")
                .resizable()
                .padding()
                .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).minY + 100)
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width * (1 + progress)  , height: size.height * (1 + progress))
            //                .clipped()
            //                .overlay(content:{
            //                    ZStack(alignment: .bottom){
            //                        Rectangle()
            //                            .fill(
            //                                .linearGradient(colors: [
            //                                    Color("purpleColor").opacity(0 - progress),
            //                                    Color("purpleColor").opacity(0.1 - progress),
            //                                    Color("purpleColor").opacity(0.3 - progress),
            //                                    Color("purpleColor").opacity(0.5 - progress),
            //                                    Color("purpleColor").opacity(0.8 - progress),
            //                                    Color("purpleColor").opacity(1 - progress)
            //
            //                                ], startPoint: .top, endPoint: .bottom))
            //                    }
            //                })
                .offset(y: -minY)
            
        }.frame(height: height + safeArea.top)
        
    }
}

struct MenuView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
