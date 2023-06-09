//
//  LoginView.swift
//  Tender
//
//  Created by Ahmad Fadly Iksan on 31/05/23.
//

import SwiftUI

struct LoginView: View {
    @State var showLogin = false
    @State var isPresented = false

    var body: some View {
        NavigationStack {
            ZStack{
                Color("whiteColor").ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("please login first".capitalized)
                        .font(.system(size: 25))
                        
                        .foregroundColor(Color("purpleColor"))
                    Spacer()
                    Image("onboarding_asset")
                    Spacer()
                    Button {
                        isPresented = true
                    }label: {
                        Image("linkedin_button")

                    }.navigationDestination(isPresented: $isPresented) {
                        ReferralView()
                    }
                    Spacer()
                    
                    
                }
                if !showLogin{
                    Color("whiteColor")
                        .edgesIgnoringSafeArea(.all)
                }
                
                VStack{
                    Image("logonew")
                        .resizable()
                        .frame(width: showLogin ? screen.width * 0.24 : screen.width * 0.48, height: showLogin ? screen.height * 0.04 : screen.height * 0.08)
                        .padding(.top, showLogin ? 60 : screen.height / 2.4)
                    Spacer()
                }.frame(width: screen.width, height: screen.height)
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.clear)
                
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    withAnimation(.spring()){
                        showLogin = true
                    }
                }
            }
        }
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

let screen = UIScreen.main.bounds
