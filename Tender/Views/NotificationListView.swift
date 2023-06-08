//
//  NotificationListView.swift
//  Tender
//
//  Created by Fajar Wirazdi on 05/06/23.
//

import SwiftUI

struct NotificationListView: View {
    @StateObject private var viewModel = NotificationListViewModel()
    @State var selectedNotif: Notification = Notification(title: "test", body: "test", name: "afdas", image: "", role: "test")
    @Binding var activeScreen: Show
    @State var isPresented: Bool = false
    var namespace: Namespace.ID

    var body: some View {
        VStack {
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        VStack {
                            MenuItem(namespace: namespace, title: "NOTIFICATION", color: Color("orangeColor"), isHeader: activeScreen == .notification ? true : false, activeScreen: $activeScreen)
                                .highPriorityGesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                                    .onEnded { value in
                                        if abs(value.translation.height) > abs(value.translation.width) {
                                            if value.translation.height > 0 {
                                                withAnimation {
                                                    activeScreen = .menu
                                                }
                                            }
                                        }
                                    }
                                )
                        }
                    }
                    List {
                        ForEach(viewModel.notifications) { notification in
                            HStack {
                                AsyncImage(url: URL(string: notification.image)) {
                                    phase in
                                    switch phase {
                                    case .empty:
                                        Color.purple.opacity(0.1)
                                            .frame(width: 50, height: 50)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                    case .failure(_):
                                        Image(systemName: "exclamationmark.icloud")
                                            .resizable()
                                            .scaledToFit()
                                    @unknown default:
                                        Image(systemName: "exclamationmark.icloud")
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Text(notification.title)
                                        .padding(.leading, 5)
                                        .foregroundColor(.black)
                                        .font(.headline)
                                    Text(notification.body)
                                        .padding(.leading, 5)
                                        .foregroundColor(.black)
                                }
                                .cornerRadius(8)
                                .padding([.top, .bottom], 10)
                                
                            }.onTapGesture {
                                selectedNotif = notification
                                isPresented.toggle()
                            }.navigationDestination(isPresented: $isPresented) {
                                RequestConnectView(notification: $selectedNotif)
                            }

//                            .padding(.top, 15)
                        }
                    }
                }
                .background(Color("whiteColor"))
                .ignoresSafeArea()
            }
            .navigationBarBackButtonHidden()
            .onAppear {
                // Add a notification to the list
                viewModel.addNotification(title: "New Request Connection", body: "Wira wants to connect with you", name: "Wira", image: "https://i.imgur.com/4ho15e6.jpg", role: "Frontend Developer")
                viewModel.addNotification(title: "New Request Connection", body: "Danu wants to connect with you", name: "Danu", image: "https://i.imgur.com/4ho15e6.jpg", role: "Backend Developer")
                viewModel.addNotification(title: "New Request Connection", body: "Iksan wants to connect with you", name: "Iksan", image: "https://i.imgur.com/4ho15e6.jpg", role: "iOS Developer")
                
            }.background(Color("whiteColor"))
        }
    }
}

class NotificationListViewModel: ObservableObject {
    @Published var notifications: [Notification] = []
    
    func addNotification(title: String, body: String, name: String, image: String, role: String) {
        let newNotification = Notification(title: title, body: body, name: name, image: image, role: role)
        notifications.append(newNotification)
    }
}


struct NotificationListView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NotificationListView(selectedNotif: Notification(title: "test", body: "test", name: "afdas", image: "", role: "test"), activeScreen: .constant(.notification), namespace: namespace)
    }
}
