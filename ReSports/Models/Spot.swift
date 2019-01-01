//
//  Spot.swift
//  ReSports
//
//  Created by 志波大輝 on 2018/12/14.
//  Copyright © 2018 志波大輝. All rights reserved.
//

import UIKit
import CoreLocation

class Spot {
    
    let name: String
    let location: CLLocation
    
    init (_ lat: CLLocationDegrees, _ lng: CLLocationDegrees, _ name: String = "") {
        self.location = CLLocation(latitude: lat, longitude: lng)
        self.name = name
    }
}

extension CLLocation {
    // 同じ座標かどうかを返す
    func isEqual(location: CLLocation?) -> Bool {
        if let location = location {
            return self.coordinate.latitude  == location.coordinate.latitude
                && self.coordinate.longitude == location.coordinate.longitude
        }
        return false
    }
    
}

private(set) var distance: CLLocationDistance?

var targetLocation: CLLocation? {
    didSet {
        guard let location = targetLocation else {
            distance = nil
            return
        }
        if location.isEqual(location: oldValue) {
            return
        }
        distance = location.distance(from: location)
    }
}

extension Spot {
    
    static var list: [Spot] {
        return [
            Spot(35.679396, 139.711963, "東京体育館"),
            Spot(35.625574, 139.663655, "駒沢オリンピック公園総合運動場"),
            Spot(35.765779, 139.825792, "東京武道館"),
            Spot(35.647651, 139.818932, "東京辰巳国際水泳場"),
            Spot(35.753929, 139.724256, "東京都障害者総合スポーツセンター"),
            Spot(35.686681, 139.446549, "東京都多摩障害者スポーツセンター"),
            Spot(35.63467, 139.788526, "有明テニスの森公園テニス施設"),
            Spot(35.630652, 139.837654, "若洲海浜公園ヨット訓練所"),
            Spot(35.664235, 139.527162, "味の素スタジアム"),
            Spot(35.64641, 139.7515, "港区スポーツセンター"),
            Spot(35.65246, 139.7277, "麻布運動場"),
            Spot(35.66896, 139.7186, "青山運動場"),
            Spot(35.63458, 139.7463, "芝浦中央公園運動場"),
            Spot(35.65458, 139.7507, "芝公園多目的運動場（アクアフィールド芝公園）"),
            Spot(35.64168, 139.7556, "埠頭少年野球場"),
            Spot(35.66974, 139.7377, "氷川武道場"),
            Spot(35.6642, 139.7491, "愛宕弓道場"),
            Spot(35.63732, 139.7599, "芝浦南ふ頭公園運動広場（かいがんぱ～く）"),
        ]
        
//        func sortedList(nearFrom location: CLLocation) -> [Spot] {
//            return self.list.sorted(by: { spot1, spot2 in
//                spot1.targetLocation = location
//                spot2.targetLocation = location
//                return spot1.distance! < spot2.distance!
//            })
//        }
    
    }
    
}
