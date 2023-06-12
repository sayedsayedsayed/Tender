//
//  GeneralHelper.swift
//  Tender
//
//  Created by Sayed Zulfikar on 31/05/23.
//

import Foundation

func generateReferenceCode() -> String{

    let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    var combination = ""

    for _ in 1...6 {
        let randomIndex = Int.random(in: 0..<characters.count)
        let randomCharacter = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
        combination.append(randomCharacter)
    }
    return combination
}

func calculateScore(mainFreelancer: Freelancer, otherFreelancer: Freelancer) -> Int {
    var result = Int.random(in: 0..<100)
    
    //TODO: make score calculation properly
    
    
    return result
}

func arrayToString(input: [String]) -> String {
    var output = ""
    
    for i in input {
        output += "|" + i
    }
    
    return output
}

func stringToArray(input: String) -> [String] {
    
    return input.components(separatedBy: "|")
        .filter { !$0.isEmpty }

}

func requestConnect(emailRequester: String, emailTarget: String) async throws{
    
    var target = try await FreelancerModel().searchFreelancerByEmail(email: emailTarget)[0]
    
    var x = stringToArray(input: target.connectRequest)
    x.append(emailRequester)
    let y = arrayToString(input: x)
    
    target.connectRequest = y
    
    try await FreelancerModel().updateFreelancer(editedFreelancer: target, type: .global)
}

func rejectConnect(freelancer: Freelancer, emailTarget: String) async throws -> String {
    var x = stringToArray(input: freelancer.connectRequest)
    x.removeAll { $0 == emailTarget }
    let y = arrayToString(input: x)
    
    var f = freelancer
    f.connectRequest = y
    
    try await FreelancerModel().updateFreelancer(editedFreelancer: f, type: .global)
    
    return y
}

func approveConnect(mainFreelancer: Freelancer, emailTarget: String) async throws -> (String, String){
    
    var x = stringToArray(input: mainFreelancer.connectRequest)
    x.removeAll { $0 == emailTarget }
    let y = arrayToString(input: x)
    
    var f = mainFreelancer
    f.connectRequest = y
    
    var a = stringToArray(input: mainFreelancer.connectList)
    a.append(emailTarget)
    let b = arrayToString(input: a)
    
    f.connectList = b
    
    try await FreelancerModel().updateFreelancer(editedFreelancer: f, type: .global)
    
    //update target data
    var targetFreelancer = try await FreelancerModel().searchFreelancerByEmail(email: emailTarget)[0]
    
    var h = stringToArray(input: targetFreelancer.connectList)
    h.append(mainFreelancer.email)
    let i = arrayToString(input: h)
    
    targetFreelancer.connectList = i
    
    try await FreelancerModel().updateFreelancer(editedFreelancer: targetFreelancer, type: .global)
    
    return (y, b)
}
