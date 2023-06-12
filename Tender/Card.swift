//
//  Card.swift
//  Tender
//
//  Created by Norman Mukhallish on 05/06/23.
//

import Foundation
import SwiftUI

// data yang dipake masih statis
struct Card: Identifiable, Hashable{
    let id = UUID()
    let name: String
    let imageName: String
    let age: Int
    let job: String
    var score: Int = 0
    let skills: [Skills]
    var urls: [URL] = []
    var reff: String
    var email: String
    var contact: String
    var addRoles: [String]
    
    var x: CGFloat = 0.0
    
    var y: CGFloat = 0.0
    
    var degree: Double = 0.0
    
    static var data: [Card]{
        [
            Card(name: "Wati", imageName: "p0", age: 22, job: "Backend Developer", skills: [Skills(image: "Python", name: "Python"), Skills(image: "Swift", name: "Swift")], urls: [URL(string: "www.google.com")!,URL(string: "www.twitter.com")!], reff: "Steve Jobs", email: "emailwati@wati.com", contact: "12345", addRoles: ["Admin", "Design"]),
        Card(name: "Sri", imageName: "p1", age: 23, job: "Frontend Developer", skills: [Skills(image: "Golang", name: "Golang"), Skills(image: "Swift", name: "Swift")], urls: [URL(string: "www.facebook.com")!,URL(string: "www.github.com")!], reff: "Steve Jobs", email: "emailwati@wati.com", contact: "12345", addRoles: ["Admin", "Design"]),
        Card(name: "Gita", imageName: "p2", age: 26, job: "UI Designer", skills: [Skills(image: "Golang", name: "Golang"), Skills(image: "Swift", name: "Swift")], urls: [URL(string: "www.github.com")!,URL(string: "www.apple.com")!], reff: "Steve Jobs", email: "emailwati@wati.com", contact: "12345", addRoles: ["Admin", "Design"]),
        Card(name: "Badrun", imageName: "p3", age: 21, job: "UX Researcher", skills: [Skills(image: "NodeJS", name: "NodeJS"), Skills(image: "Swift", name: "Swift")], urls: [URL(string: "www.youtube.com")!,URL(string: "www.stackoverflow.com")!], reff: "Steve Jobs", email: "emailwati@wati.com", contact: "12345", addRoles: ["Admin", "Design"]),
        Card(name: "Jono", imageName: "p4", age: 25, job: "Quality Assurance", skills: [Skills(image: "NodeJS", name: "NodeJS"), Skills(image: "Swift", name: "Swift")], urls: [URL(string: "www.dribbble.com")!,URL(string: "www.figma.com")!], reff: "Steve Jobs", email: "emailwati@wati.com", contact: "12345", addRoles: ["Admin", "Design"]),
        Card(name: "Jinnie", imageName: "p5", age: 23, job: "UX Designer", skills: [Skills(image: "PostgreSQL", name: "PostgreSQL"), Skills(image: "Swift", name: "Swift")], urls: [URL(string: "www.youtube.com")!,URL(string: "www.github.com")!], reff: "Steve Jobs", email: "emailwati@wati.com", contact: "12345", addRoles: ["Admin", "Design"])
        ]
    }
    
    
}
