//
//  CardData.swift
//  Tender
//
//  Created by Sayed Zulfikar on 11/06/23.
//

import Foundation

class CardData: ObservableObject {
    @Published var cards: [Card] = [Card(name: "", imageName: "", age: 0, job: "", skills: [Skills(image: "", name: "")])]
    //comment for prod
//    @Published var cards: [Card] = [Card(name: "Budi", imageName: "https://thispersondoesnotexist.com/", age: 0, job: "Admin", skills: [Skills(image: "Swift", name: "Swift")])]
    
    func calculateScore(mainFreelancer: Freelancer, otherFreelancer: Freelancer) -> Int {
        var result = Int.random(in: 0..<100)
        
        //TODO: make score calculation properly
        
        
        return result
    }
}
