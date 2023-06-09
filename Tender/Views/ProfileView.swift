//
//  ProfileView.swift
//  Tender
//
//  Created by Norman Mukhallish on 09/06/23.
//

import SwiftUI

struct ProfileView: View {
    @State var card: Card
    @State var isToggleOn: Bool = false
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Image(card.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 180)
                        .padding(.top, -10)
                    
                    Text(card.name).font(.title).bold()
                        .foregroundColor(Color("purpleColor"))
                    
                    Text(card.job)
                        .foregroundColor(Color("purpleColor"))
                    
                    Toggle(
                        isOn: $isToggleOn, label: {
                            
                        }
                    ).toggleStyle(SwitchToggleStyle(toggleText: ""))
                        .offset(x: -80)
                    
                    GeometryReader{ geometry in
                        VStack(alignment:.leading){
                            
                            HStack{
                                Image("briefcase").resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30)
                                Text("Skills").fontWeight(.bold).font(.title2)
                            }
                            HStack{
                                ForEach(card.skill, id:\.self){ subSkill in
                                    Text("\(subSkill)").foregroundColor(Color("purpleColor"))
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
                                    Text("\(url)").foregroundColor(Color("purpleColor"))
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
                                Image("portfolio").resizable()
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
                                Image("portfolio").resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30)
                                Text("Reffered By").fontWeight(.bold).font(.title2)
                            }
                            
                            HStack{
                                    Text("Steve Jobs").foregroundColor(Color("purpleColor"))
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
            }
        }
    }
}

struct SwitchToggleStyle: ToggleStyle {
    var toggleText: String
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Text(toggleText)
            Spacer()
            Button(action: { configuration.isOn.toggle() }) {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color("purpleColor"), lineWidth: 2)
                    .foregroundColor(Color("whiteColor"))
                    .frame(width: 200, height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 100)
                            .overlay(
                                configuration.isOn ? Text("Unavailable").foregroundColor(Color("whiteColor")) : Text("Available")
                                    .foregroundColor(Color("whiteColor"))
                            )
                            .foregroundColor(Color("purpleColor"))
                            .padding(2)
                            .offset(x: configuration.isOn ? 48 : -48, y: 0)
                            .animation(Animation.linear(duration: 0.2))
                    )
            }
        }
        .padding(.horizontal)
    }
}

struct ProfileView_Previews: PreviewProvider {

    static var previews: some View {
        ForEach(Card.data){ card in
            ProfileView(card: card)
        }
        
    }
}
