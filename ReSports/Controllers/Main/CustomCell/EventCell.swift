//
//  EventCell.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/07.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit

class EventCell:UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDayLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var sportsName: UILabel!
    @IBOutlet weak var yohakuView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventImage.layer.cornerRadius = 35.0
        eventImage.clipsToBounds = true
    }
    
    
    func setup(with event:Event) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ja_JP")
//        dateFormatter.doesRelativeDateFormatting = true
        eventDayLabel.text = dateFormatter.string(from: event.eventDay!)

        eventNameLabel.text = event.eventsName
        sportsName.text = event.sportsName
//        eventImage.image = user.profile
    }
    
    
}
