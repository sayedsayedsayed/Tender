//
//  CreateProfileView.swift
//  Tender
//
//  Created by Ahmad Fadly Iksan on 08/06/23.
//

import SwiftUI

struct CreateProfileView: View {
    @EnvironmentObject var user: UserViewModel
    
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
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "whiteColor")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(named: "purpleColor") as Any], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(named: "purpleColor")?.withAlphaComponent(0.4) as Any], for: .normal)
    }
    
    var body: some View {
        ZStack{
            Color("whiteColor").ignoresSafeArea()
            VStack{
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Group{
                    // FOr testing purpose only, use AsyncImage on prod
                    Image("p0")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 123, height: 123)
                        .padding(.bottom, 20)
                    //                       AsyncImage(url: URL(string: "https://thispersondoesnotexist.com/")) { image in
                    //                           image.resizable()
                    //                               .clipShape(Circle())
                    //                               .frame(width:123, height: 123)
                    
                    //                       } placeholder: {
                    //                           ProgressView()
                    //                       }
                    
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
                        TextField("", text: $mainrole, prompt: Text("Input your role").foregroundColor(Color("purpleColor").opacity(0.4)))
                            .frame(width: 350)
                            .padding(.bottom, 15)
                            .textFieldStyle(TextFieldStyleCustom())
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
                            }else{
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
                            TextField("", text: $portfolioLists[index], prompt: Text("Your portfolio link").foregroundColor(Color("purpleColor").opacity(0.4)))
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled(true)
                                .textFieldStyle(TextFieldStyleCustom())
                                .onSubmit {
                                    print (portfolioLists.filter({$0 == portfolioLists[index]}))
                                    if portfolioLists.count == 1 {
                                        portfolioLists.append("")
                                    } else if !portfolioLists[index].isEmpty && portfolioLists.filter({$0 == portfolioLists[index]}).count == 1 {
                                        portfolioLists.append("")
                                        print(portfolioLists)
                                        
                                    }
                                }
                            
                            Button{
                                if !portfolioLists[index].isEmpty{
                                    portfolioLists.remove(at: index)
                                }
                            }label: {
                                Text("X").font(.system(size: 30, weight: .bold)).foregroundColor(Color("purpleColor"))
                            }
                        }.frame(width: 350)
                    }
                    FormTitleWithIcon(iconName: "phone_icon", textTitle: "contact")
                    TextField("", text: $contactNumber, prompt: Text("Your whatsApp contact").foregroundColor(Color("purpleColor").opacity(0.4)))
                        .frame(width: 350)
                        .textFieldStyle(TextFieldStyleCustom())
                }.scrollIndicators(.hidden)
                Button {
                    print(username)
                    print(availability)
                    print(mainrole)
                    print(selectedSkills)
                    print(portfolioLists)
                    print(contactNumber)
                    if username != "" && availability && mainrole != "" && selectedSkills.count > 0 && portfolioLists.count > 0 && contactNumber != "" {
                        user.user = Users(contact: contactNumber, email: "email", isAvailable: availability, name: username, picture: "test", portfolio: portfolioLists, referee: "ME", referenceCode: "REFCODE", referenceCounter: 0, role: mainrole, skills: selectedSkills)
                        isNavigate = true
                        //                               user = tmpUser
                        print(user.user)
                    }
                }label: {
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

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView().environmentObject(UserViewModel())
    }
}
