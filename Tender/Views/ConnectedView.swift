//
//  ConnectedView.swift
//  Tender
//
//  Created by Agfid Prasetyo on 05/06/23.
//

import SwiftUI

struct ConnectedView: View {
    var namespace: Namespace.ID
//    var freelancers: [FreelancerDummyModel] = FreelancerViewModel().freelancer
    @EnvironmentObject var user: UserViewModel

    var roles: [Roles] = RolesViewModel().roles
    enum availability: String, CaseIterable {
        case available = "Available"
        case unavailable = "Unavailable"
    }

//    @State private var freelancerFiltered: [FreelancerDummyModel] = FreelancerViewModel().freelancer
    @State private var freelancerFiltered: [Users] = [Users(contact: "", email: "", isAvailable: true, name: "", picture: "", portfolio: [""], referee: "", referenceCode: "", referenceCounter: 0, mainRole: "", additionalRole: [""], skills: [Skills(image: "", name: "")], connectList: [""], connectRequest: [""])]
//    private var filteredFreelancer: [Freelancer] {
//        model.filterFreelancer(by: .all)
//    }

    @State private var isSearch: Bool = false
    @State private var search: String = ""
    @State private var isPresented: Bool = false
    @State private var isNavigate: Bool = false
    @State var selectedFreelancer: Users = Users(contact: "", email: "", isAvailable: true, name: "", picture: "", portfolio: [""], referee: "", referenceCode: "", referenceCounter: 0, mainRole: "", additionalRole: [""], skills: [Skills(image: "", name: "")], connectList: [""], connectRequest: [""])
    @State private var doneGeneratingData = false
//    @State var selectedFreelancer: FreelancerDummyModel = FreelancerDummyModel(contact: "08128238", email: "aksjdhakjs", isAvailable: true, name: "name", picture: "alskdja", portfolio: "alksdj", referee: "alskdja", referenceCounter: 1, role: "asjkd", skills: [Skills(image: "asda", name: "alskd")])
    @Binding var activeScreen: Show
    
    func onTap() {
        print("ontap")
    }

    var body: some View {
//        VStack {
//            ZStack {
                VStack(spacing: 0) {
                    MenuItem(namespace: namespace, title: "CONNECTED", isHeader: activeScreen == .connected ? true : false, activeScreen: $activeScreen)
                        .highPriorityGesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                            .onEnded { value in
                                if abs(value.translation.height) > abs(value.translation.width) {
                                    if value.translation.height > 0 {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 1)) {
                                            activeScreen = .menu
                                        }
                                    }
                                }
                            }
                        )
                    
                    
                    ScrollView {
                        ZStack {
                            if isSearch {
                                HStack(spacing: 0) {
                                    SearchBar(search: $search, isSearch: $isSearch).onChange(of: search, perform: { value in
                                        freelancerFiltered = freelancerFiltered.filter {$0.name == value}
//                                        print(freelancerFiltered)
//                                        print(value)
                                    })
                                }.ignoresSafeArea()
                            } else {
                                HStack(spacing: 10) {
                                    Spacer()
                                    Image(systemName: "magnifyingglass")
                                        .font(Font.system(.title2))
                                        .padding(.top, 15)
                                        .onTapGesture {
                                            isSearch.toggle()
                                        }
                                    Image(systemName: "line.3.horizontal.decrease")
                                        .font(Font.system(.title2))
                                        .padding(.top, 15)
                                        .onTapGesture {
                                            isPresented.toggle()
                                        }
                                }.padding(.horizontal, 30)
                                    .foregroundColor(Color.black)
                            }
                        }.ignoresSafeArea()
                        ListFreelancer(freelancers: freelancerFiltered, selectedFreelancer: $selectedFreelancer, isNavigate: $isNavigate) {
                            onTap()
                        }
                        
                    }
                    .scrollIndicators(.hidden)
                    .sheet(isPresented: $isPresented) {
                        VStack {
                            Text("Filter").font(.headline).fontWeight(.bold).padding(.vertical, 20)
                            Spacer()
                            ScrollView {
                                Accordion(title: "Skills", content: AnyView(ForEach(SkillsViewModel().skills) { skill in
                                    Checkbox(label: skill.name, onTap: {})
                                }))
                                Accordion(title: "Roles", content: AnyView(ForEach(roles) {role in
                                    Checkbox(label: role.name, onTap: {})
                                }))
                                Accordion(title: "Availability", content: AnyView(ForEach(availability.allCases, id: \.rawValue) {role in
                                    Checkbox(label: role.rawValue, onTap: {})
                                }))
                                ZStack {
                                    VStack {
                                        Spacer()
                                        Button {
                                            print("test")
                                        } label: {
                                            Text("Apply")
                                        }
                                    }
                                }
                            }
                        }.presentationDetents([.fraction(0.8)])
                    }
                }
                .onAppear(){
                    if !doneGeneratingData {
                        selectedFreelancer = user.user
                        for u in user.allUser{
                            if selectedFreelancer.connectList.contains(u.email) {
                                freelancerFiltered.append(u)
                            }
                        }
                        freelancerFiltered.removeFirst()
                        doneGeneratingData = true
                    }
                }
                
            
            .background(Color("whiteColor"))
            .ignoresSafeArea()
        .transition(.move(edge: .bottom))
    }
}

struct ConnectedView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
//        ConnectedView(namespace: namespace, selectedFreelancer: FreelancerViewModel().freelancer.first!, activeScreen: .constant(.menu))
        ConnectedView(namespace: namespace, activeScreen: .constant(.menu))
            .environmentObject(UserViewModel())
    }
}
