//
//  User.swift
//  M-V-C
//
//  Created by Axat MAC Mini 1 on 19/07/19.
//  Copyright © 2019 Axat MAC Mini 1. All rights reserved.
//

import Foundation


class User {
    var Email: String
    var Password: String
    
    init(Email: String, Password: String) {
        self.Email = Email
        self.Password = Password
    }
}

class UserDetail {
    var Email: String
    var Name: String
    var id: String
    var token: String
    var mobile: String
    
    init(Email: String, Name: String, id: String, token: String, mobile: String) {
        self.Email = Email
        self.id = id
        self.Name = Name
        self.mobile = mobile
        self.token = token
    }
}
