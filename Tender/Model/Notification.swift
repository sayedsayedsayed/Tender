//
//  Notification.swift
//  Tender
//
//  Created by Agfid Prasetyo on 08/06/23.
//

import Foundation

struct Notification: Identifiable {
    let id = UUID()
    let title: String
    let body: String
    let name: String
    let image: String
    let role: String
    var user: Users
}
