//
//  MenuView.swift
//  Tender
//
//  Created by Norman Mukhallish on 04/06/23.
//  Modified by Sayed on 11/06/23 - Connect to the DB

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
    
    @EnvironmentObject var model: FreelancerModel
    
    @State private var filterOption: FilterOptions = .all
    
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
                case .profile:
                    Tender.ProfileView(u: $user.user, activeScreen: $activeScreen, namespace: profilAnimation)
                    
                default:
                    EmptyView()
                }
                if activeScreen == .menu {
                    VStack {
                        HStack {
                            Spacer()
                            Text("Hi,")
                                .font(.body)
                                .foregroundColor(Color("purpleColor"))
                            
                            Text(user.user.name.components(separatedBy: " ")[0])
                                .font(.body).bold()
                                .foregroundColor(Color("purpleColor")).padding(.trailing, 15)
                                .matchedGeometryEffect(id: "name", in: profilAnimation)
                            
                            
                            ProfileImage
                                .frame(width: 40)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    //                    .padding(.init(top: 50, leading: 0, bottom: 0, trailing: 30))
                    
                }
            }
            .navigationBarBackButtonHidden()
            .task {
                if !model.hasPopulateData {
                    do {
                        try await model.populateFreelancer()
                        DispatchQueue.main.async {
                            print("Data Populated!")
                            let freelancers = model.filterFreelancer(by: .available)
                            
                            for freelancer in freelancers {
                                if freelancer.email != user.mainFreelancer.email {
                                    
                                    let skills = freelancer.skill.components(separatedBy: "|")
                                        .filter { !$0.isEmpty }
                                    var skillList:[Skills] = []
                                    for skill in skills {
                                        skillList.append(Skills(image: skill, name: skill))
                                    }
                                    
                                    let roles = freelancer.additionalRole.components(separatedBy: "|")
                                        .filter { !$0.isEmpty }
                                    let ports = freelancer.portfolio.components(separatedBy: "|")
                                        .filter { !$0.isEmpty }
                                    let conns = freelancer.connectList.components(separatedBy: "|")
                                        .filter { !$0.isEmpty }
                                    let reqs = freelancer.connectRequest.components(separatedBy: "|")
                                        .filter { !$0.isEmpty }
                                    
                                    var us = Users(contact: freelancer.contact, email: freelancer.email, isAvailable: freelancer.isAvailable, name: freelancer.name, picture: freelancer.picture, portfolio: ports, referee: freelancer.referee, referenceCode: freelancer.referenceCode, referenceCounter: freelancer.referenceCounter, mainRole: freelancer.mainRole, additionalRole: roles, skills: skillList, connectList: conns, connectRequest: reqs)
                                    
                                    us.score = user.calculateScore(mainFreelancer: user.mainFreelancer, otherFreelancer: freelancer)
                                    
                                    user.allUser.append(us)
                                }
                            }
                            //since the first element is an empty card
                            user.allUser.removeFirst()
                            //sort it based on Score
                            user.allUser.sort { $0.score > $1.score }
                            
                            model.hasPopulateData = true
                        }
                    } catch {
                        print(error)
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
            
            Image("logonew")
                .resizable()
                .padding()
                .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).minY + 100)
                .frame(width: 320 * (1 + progress), height: 140 * (1 + progress))
                .offset(y: -minY + 90)
            
        }.frame(height: height + safeArea.top)
        
    }
    
    var ProfileImage: some View{
        AsyncImage(url: URL(string: user.user.picture)) { image in
            image.resizable()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fit)
                .onTapGesture {
                    withAnimation {
                        activeScreen = .profile
                    }
                    
                }
            
        } placeholder: {
            ProgressView()
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    
    static var previews: some View {
        //        ContentView()
        GeometryReader{
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            
            MenuView(safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)
                .environmentObject(FreelancerModel())
                .environmentObject(UserViewModel())
        }
        //        MenuView().environmentObject(FreelancerModel())
    }
}
