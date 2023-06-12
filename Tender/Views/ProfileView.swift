//
//  ProfileView.swift
//  Tender
//
//  Created by Norman Mukhallish on 09/06/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //    @EnvironmentObject var user: UserViewModel
    let sameUser: Bool = false
    @State private var availability: Bool = true
    @State  var u: Users
    @State var isPresented = false
    @State var isNavigate = false
    @Binding var activeScreen: Show
    var namespace: Namespace.ID
    
    var btnBack: some View{
        Button(action: {
            withAnimation {
                if activeScreen == .profile {
                    activeScreen = .menu
                } else {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }) {
            
            Image(systemName: "chevron.backward")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15)
                .foregroundColor(Color("purpleColor"))
        }
    }
    
    var editButton: some View{
        HStack {
            if activeScreen == .profile {
                Button(action: {
                    withAnimation {
                        isNavigate = true
//                        print("test")
                    }
                }) {
                    Image(systemName: "pencil").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                        .foregroundColor(Color("purpleColor"))
                }.navigationDestination(isPresented: $isNavigate) {
                    CreateProfileView()
                }
                
            } else {
                EmptyView()
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack{
                        Spacer()
                        if sameUser{
                            Image(systemName: "pencil").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundColor(Color("purpleColor"))
                        }
                    }.padding(.horizontal, 40)
                        .padding(.top, 30)
                }
                VStack{
                    VStack{
                        AsyncImage(url: URL(string: u.picture)) { image in
                            image.resizable()
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                    }.frame(width: 250)
                        .padding(.top, -10)
                    
                    Text(u.name).font(.title).bold()
                        .foregroundColor(Color("purpleColor")).matchedGeometryEffect(id: "name", in: namespace)
                    
                    Text(u.mainRole)
                        .foregroundColor(Color("purpleColor"))
                    
                    if activeScreen == .menu {
                        Picker("", selection: $availability) {
                            Text("available".capitalized).tag(true)
                            Text("unavailable".capitalized).tag(false)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 11)
                                .stroke(Color("purpleColor"), lineWidth:1)
                        )
                        
                        .pickerStyle(.segmented)
                        .frame(width: 200, height: 25)
                        .padding(.bottom, -10)
                    }
                    
                    
                    
                    GeometryReader{ geometry in
                        VStack(alignment:.leading){
                            
                            HStack{
                                Image("briefcase").resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30)
                                Text("Skills").fontWeight(.bold).font(.title2)
                            }
                            HStack{
                                if u.skills.count > 0 {
                                    ForEach(u.skills, id:\.self){ subSkill in
                                        Image(subSkill.image)
                                        
                                        Text("\(subSkill.name)").foregroundColor(Color("purpleColor"))
                                            .fontWeight(.bold)
                                            .padding(.horizontal, 2)
                                            .padding(EdgeInsets(top: 4, leading: 2, bottom: 4, trailing: 2))
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color("purpleColor"),lineWidth: 2)
                                            )
                                    }
                                } else {
                                    Text("-").foregroundColor(Color("purpleColor"))
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 2)
                                        .padding(EdgeInsets(top: 4, leading: 2, bottom: 4, trailing: 2))
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color("purpleColor"),lineWidth: 2)
                                        )
                                    
                                }
                            }.onAppear {
//                                print(u)
                            }
                            
                            
                        }.foregroundColor(Color("purpleColor"))
                            .frame(width: geometry.size.width * 0.7, height: geometry.size.height)
                        
                        //still static size
                        
                        VStack(alignment:.leading){
                            HStack{
                                Image("portfolio").resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30)
                                Text("Portfolio").fontWeight(.bold).font(.title2)
                            }
                            
                            HStack{
                                
                                ForEach(u.portfolio, id:\.self){ url in
                                    Text(url)
//                                    Link("\(url)", destination: URL(string: "\(url)")!)
                                        .foregroundColor(Color("purpleColor"))
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
                            .frame(width: geometry.size.width, height: geometry.size.height * 2.3)
                        
                        VStack(alignment:.leading){
                            HStack{
                                Image(systemName: "person").resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30)
                                Text("Additional Roles").fontWeight(.bold).font(.title2)
                            }
                            HStack{
                                ForEach(u.skills, id:\.self){ subSkill in
                                    Image(subSkill.image)
                                    
                                    //                                    Text("\(subSkill.name)").foregroundColor(Color("purpleColor"))
                                    //                                        .fontWeight(.bold)
                                    //                                        .padding(.horizontal, 2)
                                    //                                        .padding(EdgeInsets(top: 4, leading: 2, bottom: 4, trailing: 2))
                                    //                                        .background(
                                    //                                            RoundedRectangle(cornerRadius: 10)
                                    //                                                .stroke(Color("purpleColor"),lineWidth: 2)
                                    //                                        )
                                }
                            }
                            
                            HStack{
                                ForEach(u.additionalRole, id:\.self){ role in
                                    Text(role).foregroundColor(Color("purpleColor"))
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
                            .frame(width: geometry.size.width * 0.72, height: geometry.size.height * 3.6)
                        
                        VStack(alignment:.leading){
                            HStack{
                                Image(systemName: "link").resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30)
                                Text("Reffered By").fontWeight(.bold).font(.title2)
                            }
                            
                            HStack{
                                Text(u.referee).foregroundColor(Color("purpleColor"))
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 2)
                                    .padding(EdgeInsets(top: 4, leading: 2, bottom: 4, trailing: 2))
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("purpleColor"),lineWidth: 2)
                                    )
                            }
                        }.foregroundColor(Color("purpleColor"))
                            .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 5)
                    }
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                //                .padding(.top, -10)
                if activeScreen != .menu{
                    HStack(alignment: .center, spacing: 100){
                        Button{
                            //TODO: create reject function
                        }label: {
                            ZStack{
                                Circle().frame(width: 59)
                                    .foregroundColor(Color("purpleColor"))
                                Image(systemName: "x.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60)
                                    .foregroundColor(Color("whiteColor"))
                            }
                        }
                        
                        
                        Button{
                            //TODO: create accept function
                        }label: {
                            ZStack{
                                Circle().frame(width: 60).foregroundColor(Color("purpleColor"))
                                Image(systemName: "checkmark").foregroundColor(Color("whiteColor")).font(.system(size: 30))
                                    .fontWeight(.semibold)
                            }
                        }
                        
                    }
                    .padding(.top, 260)
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack, trailing: editButton)
        
    }
}



struct ProfileView_Previews: PreviewProvider {
    //    @State var card: Card
    @Namespace static var namespace
    
    static var previews: some View {
        var u: Users = Users(contact: "1234", email: "sayed.fikar@gmail.com", isAvailable: true, name: "Sayed Zulfikar", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Admin", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""])
        
        ProfileView(u: u, activeScreen: .constant(.profile), namespace: namespace)
        
    }
}
