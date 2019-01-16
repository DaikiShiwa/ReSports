//
//  UserProfile.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/15.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit

class UserData: Codable {
    var id: String?
    var myName: String?
    var myAge: Int?
    var myJender: String?
    var myLocation: String?
    var myHobby: String?
    var myPhoto: String?
    
    enum CodingKeys: String, CodingKey {
        case myName
        case myAge
        case myJender
        case myLocation
        case myHobby
        case myPhoto
    }
    
    init(data: [String: Any]) {
        if let myName = data["myName"] as? String {
            self.myName = myName
        }
        if let myAge = data["myAge"] as? Int {
            self.myAge = myAge
        }
        if let myJender = data["myJender"] as? String {
            self.myJender = myJender
        }
        if let myLocation = data["myLocation"] as? String {
            self.myLocation = myLocation
        }
        if let myHobby = data["myHobby"] as? String {
            self.myHobby = myHobby
        }
        if let myPhoto = data["myPhoto"] as? String {
            self.myPhoto = myPhoto
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.myName = try container.decode(String.self, forKey: .myName)
        self.myAge = try container.decode(Int.self, forKey: .myAge)
        self.myJender = try container.decode(String.self, forKey: .myJender)
        self.myLocation = try container.decode(String.self, forKey: .myLocation)
        self.myHobby = try container.decode(String.self, forKey: .myHobby)
        self.myPhoto = try container.decode(String.self, forKey: .myPhoto)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(myName, forKey: .myName)
        try container.encode(myAge, forKey: .myAge)
        try container.encode(myJender, forKey: .myJender)
        try container.encode(myLocation, forKey: .myLocation)
        try container.encode(myHobby, forKey: .myHobby)
        try container.encode(myPhoto, forKey: .myPhoto)
    }
    
    func toData() -> [String: Any?] {
        return [
            "myName": self.myName,
            "myAge": self.myAge,
            "myJender": self.myJender,
            "myLocation": self.myLocation,
            "myHobby": self.myHobby,
            "myPhoto": self.myPhoto,
        ]
    }
    
}
