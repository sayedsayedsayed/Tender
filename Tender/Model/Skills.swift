//
//  Skills.swift
//  Tender
//
//  Created by Agfid Prasetyo on 05/06/23.
//

import Foundation

enum SkillName: String{
    case NodeJS
    case Golang
    case PostgreSQL
    case Python
    case Swift
}

struct Skills: Identifiable, Hashable {
    let image: String
    let name: String
    let id = UUID()
}
