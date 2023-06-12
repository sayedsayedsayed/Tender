//
//  SwipeView.swift
//  Tender
//
//  Created by Norman Mukhallish on 04/06/23.
//

import SwiftUI

struct SwipeView: View {
    @State private var isSearch: Bool = false
    @State private var search: String = ""
    @State private var isPresented: Bool = false
    @Binding var activeScreen: Show
    var namespace: Namespace.ID
    
    @EnvironmentObject var model: FreelancerModel
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                //Top Stack
                MenuItem(namespace: namespace, title: "DISCOVER", color: Color("purpleColor"), isHeader: activeScreen == .discover ? true : false, activeScreen: $activeScreen)
                    .background(Color("purpleColor"))
                    .highPriorityGesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                        .onEnded { value in
                            if abs(value.translation.height) > abs(value.translation.width) {
                                if value.translation.height > 0 {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 1)) {
                                        activeScreen = .menu
                                    }
                                }
                            }
                        }
                    )
                //Card
                ZStack {
                    ForEach(user.allUser) { u in
                        if u.email != user.user.email {
                            ExtractedView(u: u, activeScreen: $activeScreen, namespace: namespace).padding(8)
                        }
                    }
                }.zIndex(1.0)
                
            }.background(Color("whiteColor"))
                .edgesIgnoringSafeArea(.all)
        }.navigationBarBackButtonHidden(false)
    }
}

struct SwipeView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SwipeView(activeScreen: .constant(.discover), namespace: namespace)
            .environmentObject(UserViewModel())
    }
}

struct ExtractedView: View {
    @State var isPresented = false
    
//    @State var card: Card
    @State var u: Users
    @Binding var activeScreen: Show
    var namespace: Namespace.ID
    let cardGradient = Gradient(colors: [Color.white.opacity(1), Color.white.opacity(1)])
    var body: some View {
        ZStack(alignment: .center){
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom).frame(width: 350, height: 600).cornerRadius(8)
                
                
            VStack {
                Spacer()
                AsyncImage(url: URL(string: u.picture)) { image in
                    image.resizable()
                        .clipShape(Circle())
                        .frame(width: 200, height: 200)
                    
                } placeholder: {
                    ProgressView()
                }
                Spacer()
                VStack{
                    Text(u.name).font(.largeTitle).fontWeight(.bold)
                    Text(String(u.mainRole)).font(.title2)
                }.foregroundColor(Color("purpleColor"))
                Spacer()
                VStack(alignment:.leading){
                    
                    HStack{
                        Image("briefcase").resizable()
                            .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        Text("Skills").fontWeight(.bold).font(.title2)
                    }
                    
                    
                    HStack{
                        
                        ForEach(u.skills, id:\.self){ subSkill in
                            Text("\(subSkill.name)").foregroundColor(Color("purpleColor"))
                                .fontWeight(.bold)
                                .padding(.horizontal, 2)
                                .padding(EdgeInsets(top: 4, leading: 2, bottom: 4, trailing: 2))
                                .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("purpleColor"),lineWidth: 2)
                            )
                        }
                    }
                    
                    
                }.foregroundColor(Color("purpleColor"))
                    .frame(maxWidth: .infinity)
                    //.offset(x:-100)
                Spacer()
                
                    Button{
                        isPresented = true
                    }label:{
                        Text ("See Profile")
                            .padding(.horizontal, 15)
                            .padding(.vertical, 3)
                            .foregroundColor(Color("whiteColor")).bold()
                        //Harusnya langsung ke ProfileView
                        
                    }.buttonStyle(.borderedProminent).tint(Color("purpleColor"))                    .navigationDestination(isPresented: $isPresented){
                        ProfileView(u: u, activeScreen: $activeScreen, namespace: namespace)
                    }
                
                    //.offset(x:-100)
                //Belum Bisa Wrapping
                //Nanti coba lihat di link: https://stackoverflow.com/questions/58842453/swiftui-hstack-with-wrap
                Spacer()
            }.frame(maxWidth: .infinity)
            
            VStack{

               
            }
            .padding()
            .foregroundColor(Color("purpleColor"))
            
            HStack{
                Image("yes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .opacity(Double(u.x/10 - 1))

                Spacer()
                Image("nope")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .opacity(Double(u.x/10 * -1 - 1))
            }
            
        }
        .cornerRadius(8)
        .shadow(color: Color("purpleColor").opacity(0.2), radius: 5, x: 0, y: 0)
        
        //Step 1 - Zstack follows the coordinate of the card model
        .offset(x:u.x, y: u.y)
        .rotationEffect(.init(degrees: u.degree))
        //step 2 - gesture recogniser update the coordinate values of the card model
        .gesture(
            
            DragGesture()
            
                .onChanged{ value in
                    //user is dragging the view
                    withAnimation(.default){
                        u.x = value.translation.width
                        u.y = value.translation.height
                        u.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                    
                }
            
                .onEnded{ value in
                    withAnimation(.interpolatingSpring(mass:1.0, stiffness: 50, damping: 8, initialVelocity: 0)){
                        switch value.translation.width{
                        case 0...100:
                            u.x = 0; u.degree = 0; u.y = 0
                            
                        case let x where x > 100: //request
                            u.x = 500; u.degree = 12
                            
                        case (-100)...(-1):
                            u.x = 0; u.degree = 0; u.y = 0;
                            
                        case let x where x < -100: //reject
                            u.x = -500; u.degree = -12
                        default: u.x = 0; u.y = 0
                        }
                    }
                }
            
        )
    }
}
