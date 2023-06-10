//
//  ReferralView.swift
//  Tender
//
//  Created by Ahmad Fadly Iksan on 05/06/23.
//

import SwiftUI

struct ReferralView: View {
    @State var referral:String = ""
    @State var isPresented: Bool = false
    var body: some View {
        ZStack{
            Color("whiteColor").ignoresSafeArea()
            VStack{
                Spacer()
                Text("input your referral code".capitalized)
                    .font(.system(size: 25))
                    .foregroundColor(Color("purpleColor"))
                Spacer()
                Image("referral_asset")
                Spacer()
                TextField("", text: $referral, prompt: Text("Input referral code").font(.system(size: 24)).foregroundColor(Color("purpleColor").opacity(0.4)))
                    .textFieldStyle(TextFieldStyleCustom())
                    .frame(width: 350, height: 48)
                    .padding(.bottom, 33)
                Button{
                    isPresented = true
                }label: {
                    Text("submit".capitalized)
                        .font(.system(size: 20, weight: .medium))
                        .frame(width: 122, height: 51)
                        .foregroundColor(.white)
                        .background(Color("pinkColor"))
                        .cornerRadius(11)
                }.navigationDestination(isPresented: $isPresented) {
                    CreateProfileView()
                }
                Spacer()
            }
        }.navigationBarBackButtonHidden()
    }
}

struct ReferralView_Previews: PreviewProvider {
    static var previews: some View {
        ReferralView()
    }
}
