//
//  ProfileView.swift
//  Tender
//
//  Created by Norman Mukhallish on 09/06/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let sameUser: Bool = false
    @State private var availability: Bool = true
    @State  var card: Card
    @State var isPresented = false
    
    var btnBack: some View{
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {

            Image(systemName: "chevron.backward")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15)
                .foregroundColor(Color("purpleColor"))
        }
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
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
//                    Image("p0")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .clipShape(Circle())
//                        .frame(width: 180)
//                        .padding(.top, -10)
                    VStack{
                        AsyncImage(url: URL(string: card.imageName)) { image in
                            image.resizable()
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fit)


                        } placeholder: {
                            ProgressView()
                        }
                    }.frame(width: 250)
                        .padding(.top, -10)
                    
                    Text(card.name).font(.title).bold()
                        .foregroundColor(Color("purpleColor"))
                    
                    Text(card.job)
                        .foregroundColor(Color("purpleColor"))

                    if sameUser{
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
                                ForEach(card.skills, id:\.self){ subSkill in
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
                                ForEach(card.urls, id:\.self){ url in
                                    Link("\(url)", destination: URL(string: "\(url)")!)
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
                                
                                Text("UI Design").foregroundColor(Color("purpleColor"))
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 2)
                                    .padding(EdgeInsets(top: 4, leading: 2, bottom: 4, trailing: 2))
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("purpleColor"),lineWidth: 2)
                                    )
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
                                Text(card.reff).foregroundColor(Color("purpleColor"))
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
                if !sameUser{
                    HStack(alignment: .center, spacing: 100){
                        Button{

                        }label: {
                            ZStack{
                                Circle().frame(width: 59)
                                    .foregroundColor(Color("purpleColor"))
                                Image(systemName: "x.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60)
                                    .foregroundColor(Color("whiteColor"))
                                    
                                    
//                                Circle().frame(width: 60)
//                                    .foregroundColor(Color("whiteColor"))
//                                Text("X").foregroundColor(Color("purpleColor")).font(.system(size: 30)).bold()
                            }
                        }
                        
                        
                        Button{

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
            
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)

    }
}



struct ProfileView_Previews: PreviewProvider {
//    @State var card: Card
    
    
    static var previews: some View {
        var card = Card(name: "Wati", imageName: "https://thispersondoesnotexist.com/", age: 22, job: "Backend Developer", skills: [Skills(image: "Python", name: "Python"), Skills(image: "Swift", name: "Swift")], urls: [URL(string: "www.google.com")!,URL(string: "www.twitter.com")!], reff: "Steve Jobs")
        
        ProfileView(card: card)

    }
}
