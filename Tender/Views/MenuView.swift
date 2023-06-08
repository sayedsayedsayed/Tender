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
    
    var safeArea : EdgeInsets
    var size : CGSize
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            ZStack {
                
                    VStack(spacing: 0) {
                        
                        
                        
                        HStack {
                            LogoWork()
                        }
                        Button(action:{
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                                activeScreen = .discover
                            }
                            
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
                case .discover:
                    SwipeView(activeScreen: $activeScreen, namespace: discover)                    .transition(.move(edge: .bottom))

                    
                case .connected:
                    ConnectedView(namespace: connected, activeScreen: $activeScreen)                    .transition(.move(edge: .bottom))
                case .notification:
                    NotificationListView(activeScreen: $activeScreen, namespace: notification).transition(.move(edge: .bottom))
                default:
                    EmptyView()
                }
            }
        }.coordinateSpace(name: "SCROLL")
    }
    
    @ViewBuilder
    func LogoWork()-> some View{
        let height =  size.height * 0.45
        GeometryReader{ proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
//            let progress = minY / (height * 0.8)
            
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                .clipped()
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
