//
//  Freelancer.swift
//  Tender
//
//  Created by Agfid Prasetyo on 05/06/23.
//

import Foundation

struct FreelancerDummyModel: Identifiable, Hashable {
    var contact: String
    var email: String
    let id = UUID()
    var isAvailable: Bool
    var name: String
    var picture: String
    var portfolio: String
    var referee: String
    var referenceCounter: Int
    var role: String
    var skills: [Skills]
}
