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
    
    var body: some View {
        VStack{
            //Top Stack
            MenuItem(namespace: namespace, title: "DISCOVER", color: Color("purpleColor"), isHeader: activeScreen == .connected ? true : false, activeScreen: $activeScreen)
                .background(Color("purpleColor"))
                .highPriorityGesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                    .onEnded { value in
                        if abs(value.translation.height) > abs(value.translation.width) {
                            if value.translation.height > 0 {
                                withAnimation() {
                                    activeScreen = .menu
                                }
                            }
                        }
                    }
                )
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
    @Namespace static var namespace
    static var previews: some View {
        SwipeView(activeScreen: .constant(.menu), namespace: namespace)
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
                    .frame(maxWidth: .infinity)
                    //.offset(x:-100)
                Spacer()
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
                    .frame(maxWidth: .infinity)
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
