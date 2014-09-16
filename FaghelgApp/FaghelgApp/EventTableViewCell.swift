//
//  EventTableViewCell.swift
//  FaghelgApp
//
//  Created by Anders Ullnæss on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    init(event: Event) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "hh:mm"
        timeLabel.text = dateStringFormatter.stringFromDate(event.start)
        nameLabel.text = event.hostNames
        var durationSeconds = event.end.timeIntervalSinceDate(event.start)
        var durationMinutes = durationSeconds / 60
        durationLabel.text = String(format: "%d", durationMinutes)
        abstractLabel.text = event.description
        titleLabel.text = event.title
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
