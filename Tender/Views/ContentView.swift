//
//  ContentView.swift
//  Tender
//
//  Created by Sayed Zulfikar on 30/05/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var model: FreelancerModel
    
    var body: some View {
        GeometryReader{
            let safeArea = $0.safeAreaInsets
            let size = $0.size
           
            MenuView(safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    .environmentObject(UserViewModel())
    .environmentObject(FreelancerModel())
    }
}
