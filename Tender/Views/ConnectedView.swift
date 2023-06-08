//
//  ConnectedView.swift
//  Tender
//
//  Created by Agfid Prasetyo on 05/06/23.
//

import SwiftUI

struct ConnectedView: View {
    var namespace: Namespace.ID
    var freelancers: [FreelancerDummyModel] = FreelancerViewModel().freelancer
    var roles: [Roles] = RolesViewModel().roles
    enum availability: String, CaseIterable {
        case available = "Available"
        case unavailable = "Unavailable"
    }
    @State private var isSearch: Bool = false
    @State private var search: String = ""
    @State private var isPresented: Bool = false
    @Binding var activeScreen: Show

    var body: some View {
        VStack {
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        VStack {
                            MenuItem(namespace: namespace, title: "CONNECTED", isHeader: activeScreen == .connected ? true : false, activeScreen: $activeScreen)
                                .highPriorityGesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                                    .onEnded { value in
                                        if abs(value.translation.height) > abs(value.translation.width) {
                                            if value.translation.height > 0 {
                                                withAnimation() {
                                                    activeScreen = .menu
                                                }
                                            }
                                        }
                                    }
                                )
//                            Spacer()
                        }
                    }
                    ZStack {
                        ScrollView {
                            ZStack {
                                if isSearch {
                                    HStack(spacing: 0) {
                                        SearchBar(search: $search, isSearch: $isSearch)
                                    }.ignoresSafeArea()
                                } else {
                                    HStack(spacing: 10) {
                                        Spacer()
                                        Image(systemName: "magnifyingglass")
                                            .font(Font.system(.title2))
                                            .padding(.top, 5)
                                            .onTapGesture {
                                                isSearch.toggle()
                                            }
                                        Image(systemName: "line.3.horizontal.decrease")
                                            .font(Font.system(.title2))
                                            .padding(.top, 5)
                                            .onTapGesture {
                                                isPresented.toggle()
                                            }
                                    }.padding(.horizontal, 30)
                                        .foregroundColor(Color.black)
                                }
                            }.ignoresSafeArea()
                            ListFreelancer(freelancers: freelancers)
                            
                        }
                        .padding(.bottom, 70)
                        .scrollIndicators(.hidden)
                        .sheet(isPresented: $isPresented) {
                            VStack {
                                Text("Filter").font(.headline).fontWeight(.bold).padding(.vertical, 20)
                                Spacer()
                                ScrollView {
                                    Accordion(title: "Skills", content: AnyView(ForEach(SkillsViewModel().skills) { skill in
                                        Checkbox(label: skill.name)
                                    }))
                                    Accordion(title: "Roles", content: AnyView(ForEach(roles) {role in
                                        Checkbox(label: role.name)
                                    }))
                                    Accordion(title: "Availability", content: AnyView(ForEach(availability.allCases, id: \.rawValue) {role in
                                        Checkbox(label: role.rawValue)
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
                }
                
            }
            .background(Color("whiteColor"))
            .ignoresSafeArea()
        }.navigationBarBackButtonHidden()
    }
}

struct ConnectedView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ConnectedView(namespace: namespace, activeScreen: .constant(.menu))
    }
}
