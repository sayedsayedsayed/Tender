//
//  DataController.swift
//  Tender
//
//  Created by Sayed Zulfikar on 31/05/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FreelancerModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        }
        catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addFreelancer(email: String, name: String, picture: String, context: NSManagedObjectContext) {
        let freelancer = Freelancer(context: context)
        freelancer.id = UUID()
        freelancer.email = email
        freelancer.name = name
        freelancer.picture = picture
        
        save(context: context)
    }
    
    func editFreelancer(freelancer: Freelancer, isAvailable: Bool, picture: String, name: String, role: String, skill: String, portfolio: String, context: NSManagedObjectContext) {
        
        freelancer.isAvailable = isAvailable
        freelancer.picture = picture
        freelancer.name = name
        freelancer.role = role
        freelancer.skill = skill
        freelancer.portfolio = portfolio
        
        save(context: context)
    }
    
    func addReferee(freelancer: Freelancer, referee: String, context: NSManagedObjectContext) {
        freelancer.referee = referee
        
        save(context: context)
    }
    
    func increaseReferenceCounter(freelancer: Freelancer, context: NSManagedObjectContext) {
        freelancer.referenceCounter += 1
        
        save(context: context)
    }
}
