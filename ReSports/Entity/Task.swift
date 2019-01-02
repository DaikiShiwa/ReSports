//
//  Task.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/01.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit

class Task: Codable {
    var eventsName: String?
    var sportsName: String?
    var eventDay: Date?
    var playTime: String?
    var memberCount: String?
    var applicant: String?
    var dueDay: Date?
    var latitude: Double?
    var longitude: Double?
    var imageUrl: String?
    var reMarks: String?
    
    var deleted = false
    
    enum CodingKeys: String, CodingKey {
        case eventsName
        case sportsName
        case eventDay
        case playTime
        case memberCount
        case applicant
        case dueDay
        case latitude
        case longitude
        case imageUrl
        case reMarks
    }
    
    init(data: [String: Any]) {
        if let eventsName = data["eventsName"] as? String {
            self.eventsName = eventsName
        }
        if let sportsName = data["sportsName"] as? String {
            self.sportsName = sportsName
        }
        if let eventDay = data["eventDay"] as? Date {
            self.eventDay = eventDay
        }
        if let playTime = data["playTime"] as? String {
            self.playTime = playTime
        }
        if let memberCount = data["memberCount"] as? String {
            self.memberCount = memberCount
        }
        if let applicant = data["applicant"] as? String {
            self.applicant = applicant
        }
        if let dueDay = data["dueDay"] as? Date {
            self.dueDay = dueDay
        }
        if let latitude = data["latitude"] as? Double {
            self.latitude = latitude
        }
        if let longitude = data["longitude"] as? Double {
            self.longitude = longitude
        }
        if let imageUrl = data["imageUrl"] as? String {
            self.imageUrl = imageUrl
        }
        if let reMarks = data["reMarks"] as? String {
            self.reMarks = reMarks
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventsName = try container.decode(String.self, forKey: .eventsName)
        self.sportsName = try container.decode(String.self, forKey: .sportsName)
        self.eventDay = try container.decode(Date.self, forKey: .eventDay)
        self.playTime = try container.decode(String.self, forKey: .playTime)
        self.memberCount = try container.decode(String.self, forKey: .memberCount)
        self.applicant = try container.decode(String.self, forKey: .applicant)
        self.dueDay = try container.decode(Date.self, forKey: .dueDay)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.reMarks = try container.decode(String.self, forKey: .reMarks)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventsName, forKey: .eventsName)
        try container.encode(sportsName, forKey: .sportsName)
        try container.encode(eventDay, forKey: .eventDay)
        try container.encode(playTime, forKey: .playTime)
        try container.encode(memberCount, forKey: .memberCount)
        try container.encode(applicant, forKey: .applicant)
        try container.encode(dueDay, forKey: .dueDay)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(reMarks, forKey: .reMarks)
    }
    
    func toData() -> [String: Any?] {
        return [
            "eventsName": self.eventsName,
            "sportsName": self.sportsName,
            "eventDay": self.eventDay,
            "playTime": self.playTime,
            "memberCount": self.memberCount,
            "applicant": self.applicant,
            "dueDay": self.dueDay,
            "latitude": self.latitude,
            "longitude": self.longitude,
            "imageUrl": self.imageUrl,
            "reMarks": self.reMarks,
        ]
    }
    
}
