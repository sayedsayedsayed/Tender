//
//  MenuList.swift
//  Tender
//
//  Created by Norman Mukhallish on 04/06/23.
//

import SwiftUI

struct MenuList: Identifiable, Hashable{
    var name: String
    var color: Color
    let id = UUID()

    static func menuList() -> [MenuList]{
        return [MenuList(name: "Discover", color: Color("purpleColor")), MenuList(name: "Connected", color: Color("pinkColor")), MenuList(name: "Notification", color: Color("orangeColor")),]
    }
}

