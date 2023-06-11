//
//  UserViewModel.swift
//  Tender
//
//  Created by Agfid Prasetyo on 10/06/23.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: Users = Users(contact: "", email: "", isAvailable: true, name: "", picture: "", portfolio: [""], referee: "", referenceCode: "", referenceCounter: 0, mainRole: "", additionalRole: [""], skills: [Skills(image: "", name: "")])
    
    @Published var mainFreelancer: Freelancer = Freelancer(email: "", name: "", picture: "", referenceCode: "")
    
    @Published var cards: [Card] = [Card(name: "", imageName: "", age: 0, job: "", skills: [Skills(image: "", name: "")], reff: "")]
    @Published var mainCard: Card = Card(name: "", imageName: "", age: 0, job: "", skills: [Skills(image: "", name: "")], reff: "")
    
    //uncomment for debugging
    //    @Published var user: Users = Users(contact: "", email: "", isAvailable: false, name: "nama", picture: "https://thispersondoesnotexist.com/", portfolio: ["port1", "port2"], referee: "", referenceCode: "", referenceCounter: 0, mainRole: "role main", additionalRole: ["role1", "role2"], skills: [Skills(image: "", name: "")])
    
    
    
    //    @Published var cards: [Card] = [Card(name: "Wati", imageName: "https://thispersondoesnotexist.com/", age: 22, job: "Backend Developer", skills: [Skills(image: "Python", name: "Python"), Skills(image: "Swift", name: "Swift")], urls: [URL(string: "www.google.com")!,URL(string: "www.twitter.com")!]])
    //    @Published var mainCard: Card = Card(name: "Wati", imageName: "https://thispersondoesnotexist.com/", age: 22, job: "Backend Developer", skills: [Skills(image: "Python", name: "Python"), Skills(image: "Swift", name: "Swift")], urls: [URL(string: "www.google.com")!,URL(string: "www.twitter.com")!], reff: "Steve Jobs")
    
    func calculateScore(mainFreelancer: Freelancer, otherFreelancer: Freelancer) -> Int {
        var result = Int.random(in: 0..<100)
        
        //TODO: make score calculation properly
        
        
        return result
    }
}
