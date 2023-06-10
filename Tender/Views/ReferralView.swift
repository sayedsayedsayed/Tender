//
//  ReferralView.swift
//  Tender
//
//  Created by Ahmad Fadly Iksan on 05/06/23.
//

import SwiftUI

struct ReferralView: View {
    @EnvironmentObject var user: UserViewModel
    @State var errMessage = ""
    @State var isReffOK = false
    private var freelancerModel = FreelancerModel()
    @State private var initFreelancer: [Freelancer] = []
    
    @State var referral:String = ""
    @State var isPresented: Bool = false
    
    var body: some View {
        if errMessage == "VALID" {
            LoaderView(tintColor: .red, scaleSize: 3.0).padding(.bottom,50).padding()
                .onAppear(){
                    Task {
                        print("Updating Reffcode to DB")
                        do {
                            try await freelancerModel.updateFreelancer(editedFreelancer: user.mainFreelancer, type: .individual)
                                
                            DispatchQueue.main.async {
                                errMessage = ""
                                isReffOK = true
                                print("Update Reffcode to DB DONE!)")
                            }
                        } catch {
                            // Handle error
                            print("Error: \(error)")
                        }
                    }
                    
                }
        }
        else if !isReffOK {
            ZStack{
                Color("whiteColor").ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("input your referral code".capitalized)
                        .font(.system(size: 25))
                        .foregroundColor(Color("purpleColor"))
                    Spacer()
                    Image("referral_asset")
                    Spacer()
                    TextField("", text: $referral, prompt: Text("Input referral code").font(.system(size: 24)).foregroundColor(Color("purpleColor").opacity(0.4)))
                        .textFieldStyle(TextFieldStyleCustom())
                        .frame(width: 350, height: 48)
                        .padding(.bottom, 20)
                    Text(errMessage).foregroundColor(.red)
                    Button{
                        isPresented = true
                        
                        //Check if Reffcode is valid?
                        Task {
                            print("Checking Reffcode in DB")
                            do {
                                initFreelancer = try await freelancerModel.searchFreelancerByReffCode(reffCode: referral)
                                    
                                DispatchQueue.main.async {
                                    if referral == "SHARIA" {
                                        //hardcode for convinient
                                        print("MASTER Reffcode Detected!")
                                        errMessage = "VALID"
                                        
                                        user.user.referee = "SHARIA@apple.com"
                                        user.mainFreelancer.referee = "SHARIA@apple.com"
                                    }
                                    else {
                                        if initFreelancer.count == 0 {
                                            //ReffCode not exist in DB, show error
                                            errMessage = "ReffCode Not Found!"
                                        }
                                        else {
                                            //ReffCode exist in DB, proceed to save ReffCode
                                            print("Reffcode is Valid!")
                                            errMessage = "VALID"
                                            let theFreelancer = initFreelancer[0]
                                            
                                            //but first update uvm
                                            
                                            user.user.referee = theFreelancer.email
                                            user.mainFreelancer.referee = theFreelancer.email
                                        }
                                    }
                                }
                            } catch {
                                // Handle error
                                print("Error: \(error)")
                            }
                        }
                        
                    }label: {
                        Text("submit".capitalized)
                            .font(.system(size: 20, weight: .medium))
                            .frame(width: 122, height: 51)
                            .foregroundColor(.white)
                            .background(Color("pinkColor"))
                            .cornerRadius(11)
                    }.navigationDestination(isPresented: $isPresented) {
                        CreateProfileView()
                    }
                    Spacer()
                }
            }.navigationBarBackButtonHidden()
        }
        else if isReffOK{
            CreateProfileView()
        }
    }
}

struct ReferralView_Previews: PreviewProvider {
    static var previews: some View {
        ReferralView().environmentObject(UserViewModel())
    }
}
