//
//  LoginView.swift
//  Tender
//
//  Created by Ahmad Fadly Iksan on 31/05/23.
//  Updated by Sayed on 9

import SwiftUI
import Combine
import CloudKit

enum LoginState: String {
    case initial
    //LinkedIn
    case waitingResponse
    case gotEmail
    
    //DB
    case creatingAccount
    //    case checkingReffCode
    
    //finalise
    case hasReffCode
    case noReffCode
}

struct LoginView: View {
    @EnvironmentObject var user: UserViewModel
    
    @State var isPresent = false
    @EnvironmentObject private var logInObj: LoginViewController
    
    private var freelancerModel = FreelancerModel()
    @State private var initFreelancer: [Freelancer] = []

    var body: some View {
        
       
        switch logInObj.loginState {
        case .initial:
            DefaultLoginView(isPresent: $isPresent)
            
        case .waitingResponse:
            LoaderView(tintColor: .red, scaleSize: 3.0).padding(.bottom,50).padding()
            
        case .gotEmail:
            LoaderView(tintColor: .red, scaleSize: 3.0).padding(.bottom,50).padding()
                .onAppear() {
                    Task {
                        print("Checking Email in DB")
                        do {
                            initFreelancer = try await freelancerModel.searchFreelancerByEmail(email: logInObj.linkedInEmail)
                            DispatchQueue.main.async {
                                if initFreelancer.count == 0 {
                                    //email not exist in DB, proceed to create a new freelancer
                                    logInObj.loginState = .creatingAccount
                                }
                                else {
                                    //email exist in DB, proceed to check ReffCode
                                    let theFreelancer = initFreelancer[0]
                                    
                                    //but first update the necessary data
                                    
                                    let portofolios = theFreelancer.portfolio.components(separatedBy: "|")
                                        .filter { !$0.isEmpty }
                                    
                                    let addRoles = theFreelancer.additionalRole.components(separatedBy: "|")
                                        .filter { !$0.isEmpty }
                                    
                                    let conns = theFreelancer.connectList.components(separatedBy: "|")
                                        .filter { !$0.isEmpty }
                                    
                                    let reqs = theFreelancer.connectRequest.components(separatedBy: "|")
                                        .filter { !$0.isEmpty }
                                    
                                    
                                    let skills = theFreelancer.skill.components(separatedBy: "|")
                                        .filter { !$0.isEmpty }
                                    var skillList:[Skills] = []
                                    for s in skills {
                                        skillList.append(Skills(image: s, name: s))
                                    }
                                    
                                    let theUser = Users(contact: theFreelancer.contact, email: theFreelancer.email, isAvailable: theFreelancer.isAvailable, name: theFreelancer.name, picture: theFreelancer.picture, portfolio: portofolios, referee: theFreelancer.referee, referenceCode: theFreelancer.referenceCode, referenceCounter: theFreelancer.referenceCounter, mainRole: theFreelancer.mainRole, additionalRole: addRoles, skills: skillList, connectList: conns, connectRequest: reqs)
                                    
                                    user.user = theUser
                                    user.mainFreelancer = theFreelancer
                                    
                                    if theFreelancer.referee == "" {
                                        logInObj.loginState = .noReffCode
                                    }
                                    else {
                                        logInObj.loginState = .hasReffCode
                                    }
                                }
                                
                            }
                        } catch {
                            // Handle error
                            print("Error: \(error)")
                        }
                    }
                }
            
        case .creatingAccount:
            LoaderView(tintColor: .red, scaleSize: 3.0).padding(.bottom,50).padding()
                .onAppear() {
                    Task {
                        print("Creating New Account")
                        do {
                            let theFreelancer = Freelancer(email: logInObj.linkedInEmail, name: logInObj.linkedInFirstName + " " + logInObj.linkedInLastName, picture: logInObj.linkedInProfilePicURL, referenceCode: generateReferenceCode())
                            let recordId = try await freelancerModel.addFreelancer(freelancer: theFreelancer, type: .individual)
                            
                            DispatchQueue.main.async {
                                //Done create new freelancer, proceed to ReferralView
                                logInObj.loginState = .noReffCode
                                
                                //but first update uvm
                                user.user.recordId = recordId
                                user.user.email = theFreelancer.email
                                user.user.name = theFreelancer.name
                                user.user.picture = theFreelancer.picture
                                user.user.referenceCode = theFreelancer.referenceCode
                                
                                user.mainFreelancer.recordId = recordId
                                user.mainFreelancer.email = theFreelancer.email
                                user.mainFreelancer.name = theFreelancer.name
                                user.mainFreelancer.picture = theFreelancer.picture
                                user.mainFreelancer.referenceCode = theFreelancer.referenceCode
                                
                            }
                            
                        } catch {
                            // Handle error
                            print("Error: \(error)")
                        }
                    }
                }
            
        case .noReffCode:
            ReferralView()
            
        case .hasReffCode:
            ContentView()
        }
    }
}

struct LoaderView: View {
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 1.0
    
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}

struct DefaultLoginView: View {
    @Binding var isPresent: Bool
    
    @State var showLogin = false
    @State var isPresented = false
    
    
    var body: some View {
        
        NavigationStack {
            ZStack{
                Color("whiteColor").ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("please login first".capitalized)
                        .font(.system(size: 25))
                    
                        .foregroundColor(Color("purpleColor"))
                    Spacer()
                    Image("onboarding_asset")
                    Spacer()
                    Button {
                        isPresented = true
                    }label: {
                        Image("linkedin_button")
                        
                    }.navigationDestination(isPresented: $isPresented) {
//                        ReferralView()
                        ViewControllerWrapper()
                    }
                    Spacer()
                    
                    
                }
                if !showLogin{
                    Color("whiteColor")
                        .edgesIgnoringSafeArea(.all)
                }
                
                VStack{
                    Image("logonew")
                        .resizable()
                        .frame(width: showLogin ? screen.width * 0.24 : screen.width * 0.48, height: showLogin ? screen.height * 0.04 : screen.height * 0.08)
                        .padding(.top, showLogin ? 60 : screen.height / 2.4)
                    Spacer()
                }.frame(width: screen.width, height: screen.height)
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.clear)
                
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    withAnimation(.spring()){
                        showLogin = true
                    }
                }
            }
        }
    }
}


struct LoadingView: View {
    var body: some View {
        VStack{
            LoaderView(tintColor: .red, scaleSize: 3.0).padding(.bottom,50).padding()
            Text("Waiting Response")
        }
    }
}

let screen = UIScreen.main.bounds

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewController())
            .environmentObject(UserViewModel())
    }
}
