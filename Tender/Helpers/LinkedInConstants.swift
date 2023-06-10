//
//  LinkedInConstants.swift
//  Tender
//
//  Created by Sayed Zulfikar on 09/06/23.
//

import Foundation

struct LinkedInConstants {
    
    static let CLIENT_ID = "86agafn65pqy39"
    static let CLIENT_SECRET = "A7BlGdpWdn7WxBWl"
    static let REDIRECT_URI = "http://localhost:8080"
    static let SCOPE = "r_liteprofile%20r_emailaddress" //Get lite profile info and e-mail address
    
    static let AUTHURL = "https://www.linkedin.com/oauth/v2/authorization"
    static let TOKENURL = "https://www.linkedin.com/oauth/v2/accessToken"
}
