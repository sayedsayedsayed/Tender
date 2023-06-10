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
    case checkingEmail
    case creatingAccount
    //    case checkingReffCode
    
    
    //finalise
    case hasReffCode
    case noReffCode
}

struct LoginView: View {
    @State var isPresent = false
    
    //    @ObservedObject var logInObj = LoginViewController()
    @EnvironmentObject private var logInObj: LoginViewController
    
    @EnvironmentObject private var freelancerModel: FreelancerModel
    @State private var filterOption: FilterOptions = .all
    
    private var filteredFreelancer: [Freelancer] {
        freelancerModel.filterFreelancer(by: .all)
    }
    
    let freelancers: [Freelancer]
    
    @State private var isEmailExist: Bool = false
    @State private var hasCheckedEmail: Bool = false
    
    @State private var initFreelancer: [Freelancer] = []
    
    var body: some View {
        
        if logInObj.loginState == .initial {
            DefaultLoginView(isPresent: $isPresent)
        }
        else if logInObj.loginState == .waitingResponse{
            VStack{
                LoaderView(tintColor: .red, scaleSize: 3.0).padding(.bottom,50).padding()
                Text("Waiting Response: \(logInObj.loginState.rawValue)")
            }
        }
        else if logInObj.loginState == .gotEmail {
            VStack{
                LoaderView(tintColor: .red, scaleSize: 3.0).padding(.bottom,50).padding()
                Text("Waiting Response: \(logInObj.loginState.rawValue)")
            }
            .onAppear() {
                Task {
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
                                
                                if theFreelancer.referee == "" {
                                    logInObj.loginState = .noReffCode
                                }
                                else {
                                    logInObj.loginState = .hasReffCode
                                }
                            }
                            print("logInObj.linkedInState == .gotEmail DONE!")
                        }
                    } catch {
                        // Handle error
                        print("Error: \(error)")
                    }
                }
            }
        }
        
        else if logInObj.loginState == .creatingAccount {
            VStack{
                LoaderView(tintColor: .red, scaleSize: 3.0).padding(.bottom,50).padding()
                Text("Waiting Response: \(logInObj.loginState.rawValue)")
            }
            .onAppear() {
                Task {
                    do {
                        let freelancer = Freelancer(email: logInObj.linkedInEmail, name: logInObj.linkedInFirstName + logInObj.linkedInLastName, picture: logInObj.linkedInProfilePicURL)
                        try await freelancerModel.addFreelancer(freelancer: freelancer)
                        
                        DispatchQueue.main.async {
                            //Done create new freelancer, proceed to ReferralView
                            logInObj.loginState = .noReffCode
                        }
                        
                    } catch {
                        // Handle error
                        print("Error: \(error)")
                    }
                }
            }
        }
        else if logInObj.loginState == .noReffCode {
            ReferralView()
        }
        else if logInObj.loginState == .hasReffCode {
            ContentView()
        }
        else {
            DefaultLoginView(isPresent: $isPresent)
        }
        
        
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    //    @StateObject private var logInObj = LoginViewController()
    static var previews: some View {
        LoginView(freelancers: []).environmentObject(FreelancerModel()).environmentObject(LoginViewController())
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
    
    var body: some View {
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
                    self.isPresent = true
                }label: {
                    Image("linkedin_button")
                }
                .sheet(isPresented: $isPresent) {
                    ViewControllerWrapper()
                }
                Spacer()
                
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
