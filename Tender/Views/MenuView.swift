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
    @Namespace var profilAnimation
    @State private var menuNameList = MenuList.menuList()
    @State private var activeScreen: Show = .menu
    @State private var isFromMenu: Bool = true
    @State private var isProfileExpand = false
    
    @State private var profileX = 140.0
    @State private var profileY = 30.0
    
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
        VStack{
            
            if isProfileExpand{
                ExpandedProfileView
            }else{
                ProfileView
            }
    
        }.offset(x: profileX, y: profileY)
    }
    
    @ViewBuilder
    func LogoWork()-> some View{
        let height =  size.height * 0.3
        GeometryReader{ proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            
            let progress = minY / (height)
            
            Image("logonew")
                .resizable()
                .padding()
                .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).minY + 100)
                //.aspectRatio(contentMode: .fit)
                .frame(width: 320 * (1 + progress), height: 140 * (1 + progress))
                .offset(y: -minY + 90)
            
        }.frame(height: height + safeArea.top)
        
    }
    
    
    var ProfileView: some View {
        
        return HStack{
            VStack(alignment: .trailing){
                Text("Wati")
                    .font(.title3).bold()
                    .foregroundColor(Color("purpleColor"))
                    
                Text("Frontend Developer")
                    .foregroundColor(Color("purpleColor"))
            }
            ProfileImage
                .matchedGeometryEffect(id: profile, in: profilAnimation)
                .frame(width: 60)
        }
    }
    
    var ExpandedProfileView: some View{
        LoginView()
            .matchedGeometryEffect(id: profile, in: profilAnimation)
//        HStack{
//            ProfileImage
//                .frame(width: 120
//        }
    }
    
    var ProfileImage: some View{
        Image("p0")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .onTapGesture {
                withAnimation(.spring()){
                    profileX = 0
                    profileY = 0
                    isProfileExpand.toggle()
                }
                
            }
    }
}


struct MenuView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
