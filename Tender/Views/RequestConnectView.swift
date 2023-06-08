//
//  RequestConnectView.swift
//  Tender
//
//  Created by Ahmad Fadly Iksan on 05/06/23.
//

import SwiftUI

struct RequestConnectView: View {
    @Binding var notification: Notification

    var body: some View {
        ZStack{
            Color("whiteColor").ignoresSafeArea()
            VStack{
                Spacer()
                Text(notification.body)
                    .frame(width: 250)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("purpleColor"))
                Spacer()
                VStack{
                    AsyncImage(url: URL(string: notification.image)) {
                        phase in
                        switch phase {
                        case .empty:
                            Color.purple.opacity(0.1)
                                .frame(width: 96)
                                .padding(.top, 25)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 96)
                                .padding(.top, 25)
                        case .failure(_):
                            Image(systemName: "exclamationmark.icloud")
                                .resizable()
                                .scaledToFit()
                        @unknown default:
                            Image(systemName: "exclamationmark.icloud")
                        }
                    }
                    Spacer()
                    VStack{
                        Text(notification.name)
                            .font(.system(size: 12, weight: .bold))
                        Text(notification.role)
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
                    Text("See Full Profile".capitalized)
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
        RequestConnectView(notification: .constant(Notification(title: "New Request Connection", body: "Wira wants to connect with you", name: "Wira", image: "https://i.imgur.com/4ho15e6.jpg", role: "Frontend Developer")))
    }
}
