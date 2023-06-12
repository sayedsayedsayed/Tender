//
//  CreateProfileView.swift
//  Tender
//
//  Created by Ahmad Fadly Iksan on 08/06/23.
//

import SwiftUI

struct CreateProfileView: View {
    @EnvironmentObject var user: UserViewModel
    @State private var errMessage = ""
    private var freelancerModel = FreelancerModel()
    @State var listRole = RolesViewModel().roles.map {$0.name}
    
    // Profile value
    @State var availability: Bool = true
    @State private var username: String = ""
    @State private var mainrole: String = ""
    @State private var additionalRole: String = ""
    @State private var selectedSkills: [Skills] = []
    @State private var portfolioLists: [String] = [""]
    @State private var contactNumber: String = ""
    
    // Value to control sheet visibility
    @State private var isPresented: Bool = false
    @State private var isNavigate: Bool = false
    @State private var isDataSaved = false
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "whiteColor")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(named: "purpleColor") as Any], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(named: "purpleColor")?.withAlphaComponent(0.4) as Any], for: .normal)
    }
    
    var body: some View {
        if isDataSaved {
            ContentView()
        }
        else {
            ZStack{
                Color("whiteColor").ignoresSafeArea()
                VStack{
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Group{
                        AsyncImage(url: URL(string: user.user.picture)) { image in
                            image.resizable()
                                .clipShape(Circle())
                                .frame(width:123, height: 123)
                            
                        } placeholder: {
                            ProgressView()
                        }
                        
                        
                        Picker("", selection: $availability) {
                            Text("available".capitalized).tag(true)
                            Text("unavailable".capitalized).tag(false)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 11)
                                .stroke(Color("purpleColor"), lineWidth:1)
                        )
                        
                        .pickerStyle(.segmented)
                        .frame(width: 200, height: 25)
                        .padding(.bottom, 20)
                    }
                    Text(errMessage).foregroundColor(.red)
                    ScrollView{
                        Group{
                            FormTitleWithIcon(iconName: "name_icon", textTitle: "name")
                            TextField("", text: $username, prompt: Text("Input your name").foregroundColor(Color("purpleColor").opacity(0.4)))
                                .frame(width: 350)
                                .padding(.bottom, 15)
                                .textFieldStyle(TextFieldStyleCustom())
                        }
                        Group {
                            FormTitleWithIcon(iconName: "role_icon", textTitle: "main role")
                            TextInputAutocomplete(data: $listRole, text: $mainrole, placeholder: "Input your role")
                                .frame(width: 350)
                                .padding(.bottom, 15)
                                .textFieldStyle(TextFieldStyleCustom())
                            //                        TextField("", text: $mainrole, prompt: Text("Input your role").foregroundColor(Color("purpleColor").opacity(0.4)))
                            //                            .frame(width: 350)
                            //                            .padding(.bottom, 15)
                            //                            .textFieldStyle(TextFieldStyleCustom())
                        }
                        Group {
                            FormTitleWithIcon(textTitle: "additional role", systemName: "person" )
                            TextField("", text: $additionalRole, prompt: Text("Input your additional role").foregroundColor(Color("purpleColor").opacity(0.4)))
                                .frame(width: 350)
                                .padding(.bottom, 15)
                                .textFieldStyle(TextFieldStyleCustom())
                        }
                        Group{
                            FormTitleWithIcon(iconName: "briefcase", textTitle: "Skills")
                            HStack{
                                if selectedSkills.count == 0{
                                    Text("Input your skills").frame(width: 310, height: 40, alignment: .leading)
                                        .foregroundColor(Color("purpleColor").opacity(0.4))
                                        .background(Color("whiteColor"))
                                }
                                else{
                                    ForEach(selectedSkills.prefix(3), id:\.self) {skill in
                                        CapsuleSkillView(skill: skill)
                                    }
                                }
                                
                            }
                            .frame(width: 350, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color("purpleColor"), lineWidth:1)
                            )
                            .onTapGesture {
                                isPresented.toggle()
                            }
                        }
                        
                        
                        FormTitleWithIcon(iconName: "portfolio", textTitle: "portfolios")
                        ForEach(0..<portfolioLists.count, id: \.self) {index in
                            HStack{
                                TextField("", text: $portfolioLists[index], prompt: Text("Your portfolio link")
                                    .foregroundColor(Color("purpleColor").opacity(0.4)))
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled(true)
                                .textFieldStyle(TextFieldStyleCustom())
                                .onSubmit {
                                    //                                    print (portfolioLists.filter({$0 == portfolioLists[index]}))
                                    if portfolioLists.count == 1 {
                                        portfolioLists.append("")
                                    } else if !portfolioLists[index].isEmpty && portfolioLists.filter({$0 == portfolioLists[index]}).count == 1 {
                                        portfolioLists.append("")
                                        print(portfolioLists)
                                        
                                    }
                                }
                                
                                Button{
                                    if portfolioLists[index] == portfolioLists.last && portfolioLists.last != "" {
                                        portfolioLists.append("")
                                    } else if !portfolioLists[index].isEmpty{
                                        portfolioLists.remove(at: index)
                                    }
                                }label: {
                                    Text(portfolioLists[index] == portfolioLists.last ? "+" : "X").font(.system(size: 30, weight: .bold)).foregroundColor(Color("purpleColor"))
                                }
                            }.frame(width: 350)
                        }
                        
                        FormTitleWithIcon(iconName: "phone_icon", textTitle: "contact")
                        TextField("", text: $contactNumber, prompt: Text("Your whatsApp contact").foregroundColor(Color("purpleColor").opacity(0.4)))
                            .frame(width: 350)
                            .textFieldStyle(TextFieldStyleCustom())
                    }.scrollIndicators(.hidden)
                    Button {
                        if username == "" {
                            errMessage = "Name can not be empty!"
                        }
                        else {
                            user.user.name = username
                            user.user.mainRole = mainrole
                            if additionalRole != "" {
                                user.user.additionalRole[0] = additionalRole
                            }
                            else {
                                user.user.additionalRole = user.user.additionalRole.filter { !$0.isEmpty }
                            }
                            //                        user.user.skills = ????
                            user.user.portfolio = portfolioLists
                            user.user.contact = contactNumber
                            
                            user.mainFreelancer.name = username
                            user.mainFreelancer.mainRole = mainrole
                            if additionalRole != "" {
                                user.mainFreelancer.additionalRole = additionalRole
                            }
                            else {
                                user.user.additionalRole = user.user.additionalRole.filter { !$0.isEmpty }
                            }
                            //                        user.user.skills = ????
                            
                            var porto = ""
                            if portfolioLists.count > 0 {
                                portfolioLists.forEach { p in
                                    porto += "|" + p
                                }
                            }
                            
                            user.mainFreelancer.portfolio = porto
                            user.mainFreelancer.contact = contactNumber
                            
                            Task {
                                print("Updating details to DB")
                                do {
                                    try await freelancerModel.updateFreelancer(editedFreelancer: user.mainFreelancer, type: .individual)
                                    
                                    DispatchQueue.main.async {
                                        print("Update Reffcode to DB DONE!)")
                                        errMessage = "SAVED"
                                        isDataSaved = true
                                    }
                                } catch {
                                    // Handle error
                                    print("Error: \(error)")
                                }
                            }
                        }
                    }
                label: {
                    Text("Save Profile")
                        .frame(width: 157, height: 52)
                        .background(Color("pinkColor"))
                        .foregroundColor(Color("whiteColor"))
                        .cornerRadius(11)
                }.navigationDestination(isPresented: $isNavigate) {
                    ContentView()
                }
                }
            }
            .onAppear(){
                availability = user.user.isAvailable
                username = user.user.name
                mainrole = user.user.mainRole
                contactNumber = user.user.contact
                if user.user.additionalRole.count > 0 {
                    additionalRole = user.user.additionalRole[0]
                }
                
                if user.user.portfolio.count > 0 {
                    if user.user.portfolio[0] != "" {
                        user.user.portfolio.forEach { porto in
                            portfolioLists.append(porto)
                        }
                        portfolioLists = portfolioLists.filter { !$0.isEmpty }
                    }
                }
                
            }
            .navigationBarBackButtonHidden()
            //        .environmentObject(user)
            .sheet(isPresented: $isPresented) {
                VStack{
                    Text("Skill").font(.headline).fontWeight(.bold).padding(.vertical, 20)
                    Accordion(title: "Skills", content: AnyView(ForEach(SkillsViewModel().skills) { skill in
                        HStack {
                            Checkbox(isChecked: !selectedSkills.filter {$0.name == skill.name}.isEmpty, label: skill.name, onTap: {
                                if !selectedSkills.filter({$0.name == skill.name}).isEmpty {
                                    let id = selectedSkills.firstIndex(of: selectedSkills.filter({$0.name == skill.name}).first ?? Skills(image: "", name: ""))
                                    selectedSkills.remove(at: id!)
                                }else{
                                    selectedSkills.append(skill)
                                }
                            })
                        }
                    }))
                    Spacer()
                }.background(Color("whiteColor"))
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}


struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView().environmentObject(UserViewModel())
    }
}
