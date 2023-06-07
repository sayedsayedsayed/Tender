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
    
    var body: some Scene {
        WindowGroup {
            MenuView()
//            SayedTestView(freelancers: []).environmentObject(FreelancerModel())
        }
    }
}
