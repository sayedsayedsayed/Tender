//
//  LoginView.swift
//  Tender
//
//  Created by Ahmad Fadly Iksan on 31/05/23.
//

import SwiftUI

struct LoginView: View {
    @State var showLogin = false
    var body: some View {
        ZStack{
            Color("whiteColor").ignoresSafeArea()
            VStack{
                Spacer()
                Text("please login first".capitalized)
                    .font(.system(size: 25))
                    .offset(y: 50)
                    .foregroundColor(Color("purpleColor"))
                Spacer()
                Image("onboarding_asset")
                Spacer()
                Button {
print("test")
                }label: {
                    Image("linkedin_button")

                }
                Spacer()
                
                
            }
            if !showLogin{
                Color("whiteColor")
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack{
                Image("logo")
                    .resizable()
                    .frame(width: screen.width * 0.6, height: screen.height * 0.08)
                    .padding(.top, showLogin ? 100 : screen.height / 2.4)
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

let screen = UIScreen.main.bounds
