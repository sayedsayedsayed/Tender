//
//  SwipeView.swift
//  Tender
//
//  Created by Norman Mukhallish on 04/06/23.
//

import SwiftUI

struct SwipeView: View {
    
    var body: some View {
        VStack{
            //Top Stack
            HStack{
                Button(action: {}){
                    Image("profile")
                }
                Spacer()
                Button(action: {}){
                    Image("logo")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                }
                Spacer()
                Button(action: {}){
                    Image("chats")
                }
                
            }.padding(.horizontal)
            //Card
            ZStack {
                ForEach(Card.data.reversed()) { card in
                    ExtractedView(card: card).padding(8)
                }
            }.zIndex(1.0)
            //Bottom Stack
            HStack(spacing: 0){
                Button(action: {}){
                    Image("refresh")
                }
                Button(action: {}){
                    Image("dismiss")
                }
                Button(action: {}){
                    Image("super_like")
                }
                Button(action: {}){
                    Image("like")
                }
                Button(action: {}){
                    Image("boost")
                }
            }
        }.background(Color("whiteColor"))
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}

struct ExtractedView: View {
    
    @State var card: Card
    let cardGradient = Gradient(colors: [Color.white.opacity(1), Color.white.opacity(1)])
    var body: some View {
        ZStack(alignment: .center){
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom).frame(width: 350, height: 600).cornerRadius(8)
            VStack {
                Spacer()
                Image(card.imageName)
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                Spacer()
                VStack{
                    Text(card.name).font(.largeTitle).fontWeight(.bold)
                    Text(String(card.job)).font(.title2)
                }.foregroundColor(Color("purpleColor"))
                Spacer()
                VStack(alignment:.leading){
                    HStack{
                        Image("briefcase").resizable()
                            .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        Text("Skills").fontWeight(.bold).font(.title2)
                    }
                    
                    //Belum Bisa Wrapping
                    //Nanti coba lihat di link: https://stackoverflow.com/questions/58842453/swiftui-hstack-with-wrap
                        HStack{
                            
                                ForEach(card.skill, id:\.self){ subSkill in
                                    Text("\(subSkill)")
                            }
                        }.padding()
                    
                    
                }.foregroundColor(Color("purpleColor"))
                    .frame(width: 200)
                    //.offset(x:-100)
                Spacer()
            }
            
            VStack{

               
            }
            .padding()
            .foregroundColor(Color("purpleColor"))
            
            HStack{
                Image("yes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .opacity(Double(card.x/10 - 1))

                Spacer()
                Image("nope")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .opacity(Double(card.x/10 * -1 - 1))
            }
            
        }
        .cornerRadius(8)
        
        //Step 1 - Zstack follows the coordinate of the card model
        .offset(x:card.x, y: card.y)
        .rotationEffect(.init(degrees: card.degree))
        //step 2 - gesture recogniser update the coordinate values of the card model
        .gesture(
            
            DragGesture()
            
                .onChanged{ value in
                    //user is dragging the view
                    withAnimation(.default){
                        card.x = value.translation.width
                        card.y = value.translation.height
                        card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                    
                }
            
                .onEnded{ value in
                    withAnimation(.interpolatingSpring(mass:1.0, stiffness: 50, damping: 8, initialVelocity: 0)){
                        switch value.translation.width{
                        case 0...100:
                            card.x = 0; card.degree = 0; card.y = 0
                            
                        case let x where x > 100:
                            card.x = 500; card.degree = 12
                            
                        case (-100)...(-1):
                            card.x = 0; card.degree = 0; card.y = 0;
                            
                        case let x where x < -100:
                            card.x = -500; card.degree = -12
                        default: card.x = 0; card.y = 0
                        }
                    }
                }
            
        )
    }
}
