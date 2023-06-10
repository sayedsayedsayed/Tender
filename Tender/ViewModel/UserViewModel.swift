//
//  UserViewModel.swift
//  Tender
//
//  Created by Agfid Prasetyo on 10/06/23.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: Users = Users(contact: "", email: "", isAvailable: true, name: "", picture: "", portfolio: [""], referee: "", referenceCode: "", referenceCounter: 0, role: "", skills: [Skills(image: "", name: "")])
    
    @Published var mainFreelancer: Freelancer = Freelancer(email: "", name: "", picture: "", referenceCode: "")
}
