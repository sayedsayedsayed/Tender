//
//  FreelancerModel.swift
//  Tender
//
//  Created by Sayed Zulfikar on 06/06/23.
//

import Foundation
import CloudKit

enum TypeSaveorUpdate {
    case individual
    case global
}

// AGGREGATE MODEL for Freelancer entity
@MainActor
class FreelancerModel: ObservableObject {
    
    private var db = CKContainer.default().publicCloudDatabase
    @Published private var freelancersDictionary: [CKRecord.ID: Freelancer] = [:]
    
    @Published var hasPopulateData: Bool = false
    
    var freelancers: [Freelancer] {
        freelancersDictionary.values.compactMap { $0 }
    }
    
    //Create new freelancer
    func addFreelancer(freelancer: Freelancer, type: TypeSaveorUpdate) async throws -> CKRecord.ID {
        var defaultRecordID = CKRecord.ID(recordName: "defaultRecord")
        
        let record = try await db.save(freelancer.record)
        guard let f = Freelancer(record: record) else { return defaultRecordID}
        
        if type == .global {
            freelancersDictionary[f.recordId!] = f
        }
        
        return f.recordId!
    }
    
    //Update a freelancer
    func updateFreelancer(editedFreelancer: Freelancer, type: TypeSaveorUpdate) async throws {
        
        if type == .global {
            freelancersDictionary[editedFreelancer.recordId!] = editedFreelancer
        }
        
        do {
            let record = try await db.record(for: editedFreelancer.recordId!)
            
            record[FreelancerRecordKeys.email.rawValue] = editedFreelancer.email
            record[FreelancerRecordKeys.name.rawValue] = editedFreelancer.name
            record[FreelancerRecordKeys.picture.rawValue] = editedFreelancer.picture
            record[FreelancerRecordKeys.referee.rawValue] = editedFreelancer.referee
            record[FreelancerRecordKeys.referenceCode.rawValue] = editedFreelancer.referenceCode
            record[FreelancerRecordKeys.referenceCounter.rawValue] = editedFreelancer.referenceCounter
            record[FreelancerRecordKeys.contact.rawValue] = editedFreelancer.contact
            record[FreelancerRecordKeys.portfolio.rawValue] = editedFreelancer.portfolio
            record[FreelancerRecordKeys.mainRole.rawValue] = editedFreelancer.mainRole
            record[FreelancerRecordKeys.additionalRole.rawValue] = editedFreelancer.additionalRole
            record[FreelancerRecordKeys.skill.rawValue] = editedFreelancer.skill
            record[FreelancerRecordKeys.isAvailable.rawValue] = editedFreelancer.isAvailable
            record[FreelancerRecordKeys.connectList.rawValue] = editedFreelancer.connectList
            record[FreelancerRecordKeys.connectRequest.rawValue] = editedFreelancer.connectRequest
            
            try await db.save(record)
        } catch {
            freelancersDictionary[editedFreelancer.recordId!] = editedFreelancer        }
    }
    
    //Delete a freelancer
    func deleteFreelancer(freelancerToBeDeleted: Freelancer) async throws {
        
        freelancersDictionary.removeValue(forKey: freelancerToBeDeleted.recordId!)
        
        do {
            let _ = try await db.deleteRecord(withID: freelancerToBeDeleted.recordId!)
        } catch {
            freelancersDictionary[freelancerToBeDeleted.recordId!] = freelancerToBeDeleted
            print(error)
        }
        
    }
    
    //Search freelancer in Cloud by email
    func searchFreelancerByEmail(email: String) async throws -> [Freelancer] {

        var initFreelancerArray : [Freelancer] = []
        
        let predicate = NSPredicate(format: "email == %@", email)
        
        let query = CKQuery(recordType: FreelancerRecordKeys.type.rawValue, predicate: predicate)
        
        let result = try await db.records(matching: query)
        let records = result.matchResults.compactMap { try? $0.1.get() }
        
        records.forEach { record in
            initFreelancerArray.append(Freelancer(record: record)!)
        }
        
        return initFreelancerArray
    }
    
    //Search if ReffCode exist in Cloud
    func searchFreelancerByReffCode(reffCode: String) async throws -> [Freelancer] {
        var initFreelancerArray : [Freelancer] = []
        
        let predicate = NSPredicate(format: "referenceCode == %@", reffCode)
        
        let query = CKQuery(recordType: FreelancerRecordKeys.type.rawValue, predicate: predicate)
        
        let result = try await db.records(matching: query)
        let records = result.matchResults.compactMap { try? $0.1.get() }
        
        records.forEach { record in
            initFreelancerArray.append(Freelancer(record: record)!)
        }
        
        return initFreelancerArray
    }
    
    //Get all the freelancers data from Cloud
    func populateFreelancer() async throws {
        
        let query = CKQuery(recordType: FreelancerRecordKeys.type.rawValue, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: FreelancerRecordKeys.name.rawValue, ascending: false)]
        let result = try await db.records(matching: query)
        let records = result.matchResults.compactMap { try? $0.1.get() }
        records.forEach { record in
            freelancersDictionary[record.recordID] = Freelancer(record: record)
        }
    }
    
    //To filter the freelancers maps / not in Cloud
    func filterFreelancer(by filterOptions: FilterOptions) -> [Freelancer] {
        switch filterOptions {
            case .all:
                return freelancers
            case .available:
                return freelancers.filter { $0.isAvailable }
            case .notAvailable:
                return freelancers.filter { !$0.isAvailable }
        }
    }
    
//    func requestConnect(emailRequester: String, emailTarget: String) async throws {
//        var target = searchFreelancerByEmail(email: <#T##String#>)
//    }
}
