//
//  User.swift
//  wip_meenagram
//
//

import Foundation
import UIKit

class User: NSObject{
    
    var username: String
    var email: String
    var photo: String
    //var posts: Int
    //var followers: Int
    //var following: Int
    
    init(username: String, email: String, photo: String) {
        self.username = username
        self.email = email
        self.photo = photo
        //self.ph
    }
    convenience override init() {
        self.init(username: "", email: "", photo: "")
        //self.init(
    }
    
}
