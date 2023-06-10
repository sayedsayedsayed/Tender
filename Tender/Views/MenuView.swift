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
//    @Namespace var profile
    @Namespace var profilAnimation
    @State private var menuNameList = MenuList.menuList()
    @State private var activeScreen: Show = .menu
    @State private var isProfileExpand = false
    @EnvironmentObject var user: UserViewModel

    var safeArea : EdgeInsets
    var size : CGSize
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false){
                ZStack {
                    VStack(spacing: 0) {
                        HStack {
                            LogoWork()
                        }.padding(.bottom, 30)
                        if activeScreen == .menu {
                            Button(action:{
                                withAnimation {
                                    activeScreen = .discover
                                }
                                
                            }){
                                MenuItem(namespace: discover, title: "DISCOVER", color: Color("purpleColor"), isHeader: false, activeScreen: $activeScreen)
                            }
                            
                            
                            Button(action:{
                                withAnimation {
                                    activeScreen = .connected
                                }
                            }){
                                MenuItem(namespace: connected, title: "CONNECTED", color: Color("pinkColor"), isHeader: false, activeScreen: $activeScreen)
                            }
                            Button(action:{
                                withAnimation {
                                    activeScreen = .notification
                                }
                                
                            }){
                                MenuItem(namespace: notification, title: "NOTIFICATION", color: Color("orangeColor"), isHeader: false, activeScreen: $activeScreen)
                            }

                        }
                        
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .background(Color("whiteColor"))
            .coordinateSpace(name: "SCROLL")
            .edgesIgnoringSafeArea(.all)
            switch activeScreen {
            case .discover:
                SwipeView(activeScreen: $activeScreen, namespace: discover).transition(.move(edge: .bottom))
            case .connected:
                ConnectedView(namespace: connected, activeScreen: $activeScreen).transition(.move(edge: .bottom))
            case .notification:
                NotificationListView(activeScreen: $activeScreen, namespace: notification).transition(.move(edge: .bottom))
            default:
                EmptyView()
            }
            
            
        }.navigationBarBackButtonHidden()
        
        if activeScreen == .menu {
            VStack{
                if isProfileExpand{
                    ExpandedProfileView
                }else{
                    ProfileView
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
            
            Image("logonew")
                .resizable()
                .padding()
                .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).minY + 100)
                .frame(width: 320 * (1 + progress), height: 140 * (1 + progress))
                .offset(y: -minY + 90)
            
        }.frame(height: height + safeArea.top)
        
    }
    
    
    var ProfileView: some View {
        
        return HStack {
                Spacer()
                Text("Hi,")
                    .font(.body)
                    .foregroundColor(Color("purpleColor"))
                
            Text(user.user.name.components(separatedBy: " ")[0])
                    .font(.body).bold()
                    .foregroundColor(Color("purpleColor"))
                
                
                ProfileImage
                    .matchedGeometryEffect(id: "profile", in: profilAnimation)
                    .frame(width: 40)
        }.padding(.init(top: 50, leading: 0, bottom: 0, trailing: 30))
        

    }
    
    var ExpandedProfileView: some View{
        Tender.ProfileView(card: Card(name: "Wati", imageName: "p0", age: 22, job: "Backend Developer", skill: ["Python","Swift","SQLite"], urls: [URL(string: "www.google.com")!,URL(string: "www.twitter.com")!]))
            .matchedGeometryEffect(id: "profile", in: profilAnimation)
    }
    
    var ProfileImage: some View{
        Image("p0")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .onTapGesture {
                withAnimation {
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
