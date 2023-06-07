//
//  LoginView.swift
//  Tender
//
//  Created by Ahmad Fadly Iksan on 31/05/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
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
print("test")
                }label: {
                    Image("linkedin_button")

                }
                Spacer()
            }
            }

    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
