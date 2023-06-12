//
//  UserViewModel.swift
//  Tender
//
//  Created by Agfid Prasetyo on 10/06/23.
//

import Foundation

class UserViewModel: ObservableObject {
//    @Published var user: Users = Users(contact: "", email: "", isAvailable: true, name: "", picture: "", portfolio: [""], referee: "", referenceCode: "", referenceCounter: 0, mainRole: "", additionalRole: [""], skills: [Skills(image: "", name: "")], connectList: [""], connectRequest: [""])
//
//    @Published var allUser: [Users] = [Users(contact: "", email: "", isAvailable: true, name: "", picture: "", portfolio: [""], referee: "", referenceCode: "", referenceCounter: 0, mainRole: "", additionalRole: [""], skills: [Skills(image: "", name: "")], connectList: [""], connectRequest: [""])]
    
//    @Published var mainFreelancer: Freelancer = Freelancer(email: "", name: "", picture: "", referenceCode: "")
    
    @Published var mainFreelancer: Freelancer = Freelancer(email: "sayed.fikar@gmail.com", name: "Sayed Zulfikar", picture: "https://media.licdn.com/dms/image/C5603AQH88KfNUwwgRQ/profile-displayphoto-shrink_400_400/0/1659192621122?e=1692230400&v=beta&t=GeYjtU7_qUEeMRp9lZuna7Sc3nbF8A6cturWHxZc1Vc", referee: "Admin", referenceCode: "SHARIA", referenceCounter: 0, contact: "1234", portfolio: "porto1|porto2", mainRole: "Designer", additionalRole: "Back-end Developer|Product Manager", skill: "Swift|Golang", isAvailable: true, connectList: "3@gmail.com|4@gmail.com", connectRequest: "1@gmail.com|2@gmail.com")
    
    @Published var user: Users = Users(contact: "1234", email: "sayed.fikar@gmail.com", isAvailable: true, name: "Sayed Zulfikar", picture: "https://media.licdn.com/dms/image/C5603AQH88KfNUwwgRQ/profile-displayphoto-shrink_400_400/0/1659192621122?e=1692230400&v=beta&t=GeYjtU7_qUEeMRp9lZuna7Sc3nbF8A6cturWHxZc1Vc", portfolio: ["porto1", "porto2"], referee: "Admin", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: ["3@gmail.com", "4@gmail.com"], connectRequest: ["1@gmail.com", "2@gmail.com"])

    @Published var allUser: [Users] = [
        Users(contact: "1234", email: "sayed.fikar@gmail.com", isAvailable: true, name: "Sayed Zulfikar", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Admin", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""]),
        Users(contact: "1234", email: "1@gmail.com", isAvailable: true, name: "Tes Satu", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Sayed Zulfikar", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""]),
        Users(contact: "1234", email: "2@gmail.com", isAvailable: true, name: "Tes Dua", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Sayed Zulfikar", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""]),
        Users(contact: "1234", email: "3@gmail.com", isAvailable: true, name: "Tes Tiga", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Sayed Zulfikar", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""]),
        Users(contact: "1234", email: "4@gmail.com", isAvailable: true, name: "Tes Empat", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Sayed Zulfikar", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""]),
        Users(contact: "1234", email: "5@gmail.com", isAvailable: true, name: "Tes Lima", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Sayed Zulfikar", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""]),
        Users(contact: "1234", email: "6@gmail.com", isAvailable: true, name: "Tes Enam", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Sayed Zulfikar", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""]),
        Users(contact: "1234", email: "7@gmail.com", isAvailable: true, name: "Tes Tujuh", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Sayed Zulfikar", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""]),
        Users(contact: "1234", email: "8@gmail.com", isAvailable: true, name: "Tes Lapan", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Sayed Zulfikar", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""]),
        Users(contact: "1234", email: "9@gmail.com", isAvailable: true, name: "Tes Sembilan", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Sayed Zulfikar", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""]),
        Users(contact: "1234", email: "10@gmail.com", isAvailable: true, name: "Tes Sepuluh", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Sayed Zulfikar", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""]),
        Users(contact: "1234", email: "11@gmail.com", isAvailable: true, name: "Tes Sebelas", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Sayed Zulfikar", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""])
    ]

    func calculateScore(mainFreelancer: Freelancer, otherFreelancer: Freelancer) -> Int {
        var result = Int.random(in: 0..<100)
        
        //TODO: make score calculation properly
        
        
        return result
    }
}
