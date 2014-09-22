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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    func setEvent(event: Event) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "hh:mm"
        timeLabel.text = dateStringFormatter.stringFromDate(event.start)
        nameLabel.text = event.hostNames
        var durationSeconds = event.end.timeIntervalSinceDate(event.start)
        var durationMinutes = durationSeconds / 60
        durationLabel.text = String(format: "%d", durationMinutes)
        abstractLabel.text = event.desc
        titleLabel.text = event.title
    }
}
