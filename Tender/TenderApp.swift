//
//  TenderApp.swift
//  Tender
//
//  Created by Sayed Zulfikar on 30/05/23.
//

import SwiftUI

@main
struct TenderApp: App {

    var logInObj = LoginViewController()
    var user = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()

            LoginView()
                .environmentObject(logInObj)
                .environmentObject(user)
                .environmentObject(FreelancerModel())
            
//            SayedTestView(freelancers: []).environmentObject(FreelancerModel())
        }
    }
}
