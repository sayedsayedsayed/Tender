//
//  ReferenceHelper.swift
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

func decryptReferenceCode(referenceCode: String) -> (Int, Int){
    //TODO: dechipher the reference code
    var id = 0
    var counter = 0
    return (id, counter)
}

func checkReferenceCode(id: Int, counter: Int) -> Bool {
    //TODO: check if the reference code is valid or not
    var result = true
    return result
}


