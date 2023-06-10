//
//  UserViewModel.swift
//  Tender
//
//  Created by Agfid Prasetyo on 10/06/23.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: Users = Users(contact: "", email: "", isAvailable: true, name: "", picture: "", portfolio: [""], referee: "", referenceCounter: 0, role: "", skills: [Skills(image: "", name: "")])
}
