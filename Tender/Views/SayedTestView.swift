//
//  SayedTestView.swift
//  Tender
//
//  Created by Sayed Zulfikar on 31/05/23.
//  Used only for experimenting / POC purpose, please do not modify this as this is my personal playground

import SwiftUI
import CoreData
import WebKit
import CloudKit

struct WebView: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct SayedTestView: View {
    
    @EnvironmentObject private var model: FreelancerModel
    @State private var taskTitle: String = ""
    @State private var filterOption: FilterOptions = .all
    
    private var filteredFreelancer: [Freelancer] {
        model.filterFreelancer(by: .all)
    }
    
    let freelancers: [Freelancer]
    
    @State private var mainFreelancer = Freelancer(email: "", name: "", picture: "", referenceCode: "")
    
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
    
    private let emptyFreelancer = Freelancer(email: "", name: "", picture: "", referenceCode: "")
    
    @State private var selectedFreelancer = Freelancer(email: "", name: "", picture: "", referenceCode: "")
    
    @State private var showLinkedIn = false
    
    @State private var linkedInId = ""
    @State private var linkedInFirstName = ""
    @State private var linkedInLastName = ""
    @State private var linkedInEmail = ""
    @State private var linkedInProfilePicURL = ""
    @State private var linkedInAccessToken = ""
    
    @State private var showWebView = false
    
    @State var isPresent = Bool()

    
    var body: some View {
        if showLinkedIn == true {
            VStack{
                Button(action: {
                    self.isPresent = true
                    
                }) {
                    Text("LinkedIn SignIn")
                        .font(Font.headline)
                        .frame(width: 250, height: 60, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(30)
                        .sheet(isPresented: $isPresent) {
//                            ViewControllerWrapper()
                    }
                }
                Button("Login With LinkedIn!") {
//                    linkedInAuthVC()
                }
            }
        }
        else {
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
                                        let freelancer = Freelancer(email: email, name: name, picture: picture, referenceCode: generateReferenceCode())
                                        Task {
                                            try await model.addFreelancer(freelancer: freelancer, type: .global)
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
                                    selectedFreelancer.mainRole = role
                                    selectedFreelancer.skill = skill
                                    Task {
                                        try await model.updateFreelancer(editedFreelancer: selectedFreelancer, type: .global)
                                        
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
                                    searchEmail = searchEmail.capitalized
//                                    if try await model.searchFreelancerByEmail(email: searchEmail) {
//                                        isFound = "KETEMU!"
//                                    }
//                                    else {
//                                        isFound = "GA NEMU! \(searchEmail)"
//                                    }
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
                            ForEach(Array(filteredFreelancer.enumerated()), id: \.1.recordId) { index, freelancer in
                                HStack {
                                    Text(freelancer.name)
                                    Spacer()
                                    Text(freelancer.email)
                                    Button{

                                        
//                                        let f = model.freelancers[index]
//                                        let x = model.freelancerd

//                                        let newReq = CKRecord.Reference(recordID: freelancer.recordId!, action: .none)
                                        
//                                        var updatedWantToConnect: [CKRecord.Reference] = mainFreelancer.wantToConnect!
//                                        updatedWantToConnect.append(newReq)
                                        
//                                        mainFreelancer.wantToConnect = [newReq]
                                        mainFreelancer.connectRequest += "|" + freelancer.email + "|"
                                        Task{
                                            try await model.updateFreelancer(editedFreelancer: mainFreelancer, type: .global)
                                            
                                            DispatchQueue.main.async {
                                                print("updated")
                                            }
                                        }
                                        
                                    }label:{
                                        Text ("Connect")
                                            .foregroundColor(Color("whiteColor")).bold()
                                    }.buttonStyle(.borderedProminent).tint(Color("purpleColor"))
                                    
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
                                    role = selectedFreelancer.mainRole
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
                        
                        
                        DispatchQueue.main.async {
                            for freelancer in filteredFreelancer {
                                if freelancer.email == "sayed.fikar@gmail.com" {
                                    mainFreelancer = freelancer
                                }
                            }
                            
                        }
                    } catch {
                        print(error)
                    }
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


