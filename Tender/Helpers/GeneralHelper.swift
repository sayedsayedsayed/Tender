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


