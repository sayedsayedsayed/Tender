//
//  TenderApp.swift
//  Tender
//
//  Created by Sayed Zulfikar on 30/05/23.
//

import SwiftUI

@main
struct TenderApp: App {
//    let persistenceContainer = PersistenceController.shared
    @StateObject private var logInObj = LoginViewController()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            LoginView(freelancers: []).environmentObject(FreelancerModel()).environmentObject(logInObj)
//            SayedTestView(freelancers: []).environmentObject(FreelancerModel())
        }
    }
}
