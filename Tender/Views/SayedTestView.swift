//
//  SayedTestView.swift
//  Tender
//
//  Created by Sayed Zulfikar on 31/05/23.
//  Used only for experimenting / POC purpose, please do not modify this as this is my personal playground

import SwiftUI
import CoreData

struct SayedTestView: View {
    
    @EnvironmentObject private var model: FreelancerModel
    @State private var taskTitle: String = ""
    @State private var filterOption: FilterOptions = .all
    
    private var filteredFreelancer: [Freelancer] {
        model.filterFreelancer(by: .all)
    }
    
    let freelancers: [Freelancer]
    
    @State private var showingAddView = false
    @State private var showingEditView = false
    @State private var name = ""
    @State private var email = ""
    @State private var picture = ""
    @State private var referee = ""
    @State private var referenceCounter = 0
    @State private var contact = ""
    @State private var portfolio = ""
    @State private var role = ""
    @State private var skill = ""
    @State private var isAvailable = true
    
    @State private var searchEmail = ""
    @State private var isFound = ""
    
    private let emptyFreelancer = Freelancer(email: "", name: "", picture: "")
    
    @State private var selectedFreelancer = Freelancer(email: "", name: "", picture: "")
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if showingAddView {
                    Form {
                        Section() {
                            TextField("Name", text: $name)
                            TextField("Email", text: $email)
                            TextField("Picture", text: $picture)
                            
                            HStack {
                                Spacer()
                                Button("Add Freelancer") {
                                    let freelancer = Freelancer(email: email, name: name, picture: picture)
                                    Task {
                                        try await model.addFreelancer(freelancer: freelancer)
                                        name = ""
                                        email = ""
                                        picture = ""
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                }
                else if showingEditView {
                    VStack{
                        Form {
                            Section() {
                                TextField("Name", text: $name)
                                TextField("Email", text: $email)
                                TextField("Picture", text: $picture)
                                TextField("referee", text: $referee)
                                TextField("referenceCounter", value: $referenceCounter, formatter: NumberFormatter())
                                TextField("contact", text: $contact)
                                TextField("portfolio", text: $portfolio)
                                TextField("role", text: $role)
                                TextField("skill", text: $skill)
                                
                                Toggle("IsAvailable", isOn: $isAvailable)
                                
                                
                                
                            }
                        }
                        HStack {
                            Spacer()
                            Button("Edit Freelancer") {
                                selectedFreelancer.name = name
                                selectedFreelancer.email = email
                                selectedFreelancer.picture = picture
                                selectedFreelancer.referee = referee
                                selectedFreelancer.referenceCounter = referenceCounter
                                selectedFreelancer.contact = contact
                                selectedFreelancer.portfolio = portfolio
                                selectedFreelancer.role = role
                                selectedFreelancer.skill = skill
                                Task {
                                    try await model.updateFreelancer(editedFreelancer: selectedFreelancer)
                                    
                                    selectedFreelancer = emptyFreelancer
                                    showingAddView = false
                                    showingEditView = false
                                }
                            }
                            Spacer()
                        }
                    }
                }
                else {
                    TextField("Name", text: $searchEmail)
                        .padding()
                    HStack {
                        Spacer()
                        Button("Search by Email Freelancer") {
//                            let freelancer = Freelancer(email: email, name: name, picture: picture)
                            Task {
                                if try await model.searchFreelancerByEmail(email: searchEmail) {
                                    isFound = "KETEMU!"
                                }
                                else {
                                    isFound = "GA NEMU!"
                                }
                                searchEmail = ""
                            }
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(isFound)
                        Spacer()
                    }
                    List {
                        ForEach(filteredFreelancer, id: \.recordId) { freelancer in
                            HStack {
                                Text(freelancer.name)
                                Spacer()
                                Text(freelancer.email)
                            }
                            .onTapGesture {
                                selectedFreelancer = freelancer
                                name = selectedFreelancer.name
                                email = selectedFreelancer.email
                                picture = selectedFreelancer.picture
                                referee = selectedFreelancer.referee
                                referenceCounter = selectedFreelancer.referenceCounter
                                contact = selectedFreelancer.contact
                                portfolio = selectedFreelancer.portfolio
                                role = selectedFreelancer.role
                                skill = selectedFreelancer.skill
                                showingEditView = true
                                showingAddView = false
                            }
                        }
                        .onDelete { indexSet in
                            
                            guard let index = indexSet.map({ $0 }).last else {
                                return
                            }
                            
                            let freelancer = model.freelancers[index]
                            Task {
                                do {
                                    try await model.deleteFreelancer(freelancerToBeDeleted: freelancer)
                                } catch {
                                    print(error)
                                }
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("Tender")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        name = ""
                        email = ""
                        picture = ""
                        showingAddView.toggle()
                    } label: {
                        Label("Add freelancer", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add freelancer", systemImage: "plus.circle")
                    }
                }
            }
            .task {
                do {
                    try await model.populateFreelancer()
                } catch {
                    print(error)
                }
            }
        }
    }
    
}

struct SayedTestView_Previews: PreviewProvider {
    static var previews: some View {
        SayedTestView(freelancers: []).environmentObject(FreelancerModel())
    }
}
