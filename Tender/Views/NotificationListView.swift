//
//  NotificationListView.swift
//  Tender
//
//  Created by Fajar Wirazdi on 05/06/23.
//

import SwiftUI

struct NotificationListView: View {
    @StateObject private var viewModel = NotificationListViewModel()
    @Binding var activeScreen: Show
    var namespace: Namespace.ID

    var body: some View {
        NavigationView {
            MenuItem(namespace: namespace, title: "NOTIFICATION", color: Color("orangeColor"), isHeader: activeScreen == .notification ? true : false, activeScreen: $activeScreen)
                .highPriorityGesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                    .onEnded { value in
                        if abs(value.translation.height) > abs(value.translation.width) {
                            if value.translation.height > 0 {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    activeScreen = .menu
                                }
                            }
                        }
                    }
                )

            List {
                ForEach(viewModel.notifications) { notification in
                    HStack {
                        AsyncImage(url: URL(string: notification.image))
//                        Image(notification.image)
//                            .resizable()
                            .frame(width: 50, height: 50)
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
                    }
                    
                }
                
            }
//            .navigationTitle("Notifications")
            .padding(.top, 15)
        }
        .onAppear {
            // Add a notification to the list
            viewModel.addNotification(title: "New Request Connection", body: "Wira wants to connect with you", name: "Wira", image: "profilPic")
        }
    }
}

struct Notification: Identifiable {
    let id = UUID()
    let title: String
    let body: String
    let name: String
    let image: String
}

class NotificationListViewModel: ObservableObject {
    @Published var notifications: [Notification] = []
    
    func addNotification(title: String, body: String, name: String, image: String) {
        let newNotification = Notification(title: title, body: body, name: name, image: image)
        notifications.append(newNotification)
    }
}


struct NotificationListView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NotificationListView(activeScreen: .constant(.notification), namespace: namespace)
    }
}
