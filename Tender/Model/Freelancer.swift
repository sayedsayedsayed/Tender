//
//  Freelancer.swift
//  Tender
//
//  Created by Sayed Zulfikar on 06/06/23.
//

import Foundation
import CloudKit

enum FreelancerRecordKeys: String {
    case type = "Freelancer"
    case email
    case name
    case picture
    case referee
    case referenceCode
    case referenceCounter
    case contact
    case portfolio
    case mainRole
    case additionalRole
    case skill
    case isAvailable
}

enum FilterOptions: String, CaseIterable {
    case all
    case available
    case notAvailable
}

struct Freelancer {
    
    var recordId: CKRecord.ID?
    var email: String
    var name: String
    var picture: String
    var referee: String = ""
    var referenceCode: String
    var referenceCounter: Int = 0
    var contact: String = ""
    var portfolio: String = ""
    var mainRole: String = ""
    var additionalRole: String = ""
    var skill: String = ""
    var isAvailable: Bool = true
    
}

extension Freelancer {
    init?(record: CKRecord) {
        guard let email = record[FreelancerRecordKeys.email.rawValue] as? String,
              let name = record[FreelancerRecordKeys.name.rawValue] as? String,
              let picture = record[FreelancerRecordKeys.picture.rawValue] as? String,
              let referee = record[FreelancerRecordKeys.referee.rawValue] as? String,
              let referenceCode = record[FreelancerRecordKeys.referenceCode.rawValue] as? String,
              let referenceCounter = record[FreelancerRecordKeys.referenceCounter.rawValue] as? Int,
              let contact = record[FreelancerRecordKeys.contact.rawValue] as? String,
              let portfolio = record[FreelancerRecordKeys.portfolio.rawValue] as? String,
              let mainRole = record[FreelancerRecordKeys.mainRole.rawValue] as? String,
              let additionalRole = record[FreelancerRecordKeys.additionalRole.rawValue] as? String,
              let skill = record[FreelancerRecordKeys.skill.rawValue] as? String,
              let isAvailable = record[FreelancerRecordKeys.isAvailable.rawValue] as? Bool else {
            return nil
        }
        
        self.init(recordId: record.recordID, email: email, name: name, picture: picture, referee: referee, referenceCode: referenceCode, referenceCounter: referenceCounter, contact: contact, portfolio: portfolio, mainRole: mainRole, additionalRole: additionalRole, skill: skill, isAvailable: isAvailable)
    }
}

extension Freelancer {
    
    var record: CKRecord {
        let record = CKRecord(recordType: FreelancerRecordKeys.type.rawValue)
        record[FreelancerRecordKeys.email.rawValue] = email
        record[FreelancerRecordKeys.name.rawValue] = name
        record[FreelancerRecordKeys.picture.rawValue] = picture
        record[FreelancerRecordKeys.referee.rawValue] = referee
        record[FreelancerRecordKeys.referenceCode.rawValue] = referenceCode
        record[FreelancerRecordKeys.referenceCounter.rawValue] = referenceCounter
        record[FreelancerRecordKeys.contact.rawValue] = contact
        record[FreelancerRecordKeys.portfolio.rawValue] = portfolio
        record[FreelancerRecordKeys.mainRole.rawValue] = mainRole
        record[FreelancerRecordKeys.additionalRole.rawValue] = additionalRole
        record[FreelancerRecordKeys.skill.rawValue] = skill
        record[FreelancerRecordKeys.isAvailable.rawValue] = isAvailable
        return record
    }
    
}
