//
//  UserViewModel.swift
//  Tender
//
//  Created by Agfid Prasetyo on 10/06/23.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: Users = Users(contact: "", email: "", isAvailable: true, name: "", picture: "", portfolio: [""], referee: "", referenceCode: "", referenceCounter: 0, mainRole: "", additionalRole: [""], skills: [Skills(image: "", name: "")])
    
    //uncomment for debugging
//    @Published var user: Users = Users(contact: "", email: "", isAvailable: false, name: "nama", picture: "https://thispersondoesnotexist.com/", portfolio: ["port1", "port2"], referee: "", referenceCode: "", referenceCounter: 0, mainRole: "role main", additionalRole: ["role1", "role2"], skills: [Skills(image: "", name: "")])
    
    @Published var mainFreelancer: Freelancer = Freelancer(email: "", name: "", picture: "", referenceCode: "")
}
