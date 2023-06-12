//
//  ConnectedCard.swift
//  Tender
//
//  Created by Agfid Prasetyo on 05/06/23.
//

import SwiftUI

struct ConnectedCard: View {
    enum Available: String {
        case available = "Available"
        case unavailable = "Unavailable"
    }
    var freelancer: Users
    var available: Available = .available
    
    init(freelancer: Users) {
        self.freelancer = freelancer
        self.available = freelancer.isAvailable ? .available : .unavailable
    }

//    var name: String = "Agfid Prasetyo"
//    var skills: [Skills] = SkillsViewModel().skills
//
//        private var
//    var skills: [String] = ["ReactJs", "NextJs", "Rust", "MySql", "Java"]
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    HStack {
                        Circle().foregroundColor(available == .available ? Color("orangeColor") : Color("unavailableColor"))
                            .frame(width: /*@START_MENU_TOKEN@*/13.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/13.0/*@END_MENU_TOKEN@*/)
                        Text(available.rawValue)
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("purpleColor"))
                            .bold()
                            .padding(.vertical, 2.0)
                    }
                    .padding(.horizontal, 5.0)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("purpleColor"), lineWidth: 1))
                }.padding(.trailing, 5)
                ZStack {
                    VStack(alignment: .leading) {
                        HStack(spacing: 5) {
                            Image(systemName: "briefcase").foregroundColor(Color("purpleColor")).font(Font.system(.callout))
                            Text("Skills")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(Color("purpleColor"))
                            Spacer()
                        }.padding(.horizontal, 10)
                        ListSkills(skills: freelancer.skills).padding(.leading, 10)
                    }
                }
                Spacer()
                ZStack {
                    Rectangle()
                        .frame(height: 75)
                        .foregroundColor(Color("pinkColor"))
                        .padding(.top, 12)
                        .cornerRadius(12)
                        .padding(.bottom, -12)
                    Image("profilPic")
                        .padding(.top, -45)
                    ZStack {
                        VStack {
                            Text(freelancer.name).font(.caption).fontWeight(.bold).foregroundColor(Color.white).multilineTextAlignment(.center)
                            Text(freelancer.mainRole)
                                .font(.caption)
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                        }
                    }.padding(.top, 30)
                }
            }.padding(.top, 10)
        }
        .frame(width: /*@START_MENU_TOKEN@*/165.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/220.0/*@END_MENU_TOKEN@*/)
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white))
    }
}

struct ConnectedCard_Previews: PreviewProvider {
    static var previews: some View {
        ConnectedCard(freelancer: Users(contact: "1234", email: "sayed.fikar@gmail.com", isAvailable: true, name: "Sayed Zulfikar", picture: "https://thispersondoesnotexist.com/", portfolio: ["porto1", "porto2"], referee: "Admin", referenceCode: "SHARIA", referenceCounter: 0, mainRole: "Designer", additionalRole: ["Back-end Developer", "Product Manager"], skills: [Skills(image: "Swift", name: "Swift"), Skills(image: "Golang", name: "Golang")], connectList: [""], connectRequest: [""]))
    }
}
