//
//  RequestConnectView.swift
//  Tender
//
//  Created by Ahmad Fadly Iksan on 05/06/23.
//

import SwiftUI

struct DetailNotificationView: View {
    let user: String = "danu"
    let role: String = "frontend developer"

    var body: some View {
        ZStack{
            Color("whiteColor").ignoresSafeArea()
            VStack{
                Spacer()
                Text("\(user.capitalized) wants to connect with you")
                    .frame(width: 250)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("purpleColor"))
                Spacer()
                VStack{
                    Image("p0")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 96)
                    Spacer()
                    VStack{
                        Text("Prasetyo Danu")
                            .font(.system(size: 12, weight: .bold))
                        Text(role)
                            .font(.system(size: 12, weight: .medium))

                    }
                    .frame(width: 165, height: 75)
                    .background(Color("pinkColor"))
                    .foregroundColor(Color("whiteColor"))

                }

                .frame(width: 165, height: 219)
                .background(.white)
                .cornerRadius(10)
                .shadow(radius: 2, x: 0, y: 3)
                Ellipse()
                    .frame(width: 228, height: 52)
                    .foregroundColor(Color("whiteColor"))
                    .shadow(radius: 1.5, x: 1, y: 1)
                Spacer()
                Button {
                    print("test button")
                }label: {
                    Text("detail profile".capitalized)
                        .frame(width: 173, height: 51)
                        .foregroundColor(.white)
                        .background(Color("pinkColor"))
                        .cornerRadius(11
                        )
                }
                Spacer()
            }
        }
    }
}

struct RequestConnectView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNotificationView()
    }
}
