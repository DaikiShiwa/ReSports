//
//  UserProfile.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/15.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit

struct UserProfile: Codable {
    let name: String
    let age: Int?
    let jender: String?
    let location: String?
    let hobby: String?
    let photo: String?
    
    init(name: String,
         age: Int?,
         jender: String?,
         location: String?,
         hobby: String?,
         photo: String?) {
        self.name = name
        self.age = age
        self.jender = jender
        self.location = location
        self.hobby = hobby
        self.photo = photo
    }
    
}
