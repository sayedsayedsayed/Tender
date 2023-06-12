//
//  Users.swift
//  Tender
//
//  Created by Agfid Prasetyo on 10/06/23.
//  Modified by Sayed on 11/06/23 - add vars

import Foundation
import CloudKit

struct Users: Identifiable, Hashable {
    var recordId: CKRecord.ID?
    var contact: String
    var email: String
    let id = UUID()
    var isAvailable: Bool
    var name: String
    var picture: String
    var portfolio: [String]
    var referee: String
    var referenceCode: String
    var referenceCounter: Int
    var mainRole: String
    var additionalRole: [String]
    var skills: [Skills]
    var score: Int = 0
    var connectList: [String]
    var connectRequest: [String]
    
    //for dragGesture
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var degree: Double = 0.0
}
