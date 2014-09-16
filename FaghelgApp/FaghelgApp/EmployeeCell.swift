//
//  EmployeeCell.swift
//  FaghelgApp
//
//  Created by Patrick Romstad on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {

    @IBOutlet weak var fullName: UILabel!
    var shortName: String!
    @IBOutlet weak var employeeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fullName.lineBreakMode = NSLineBreakMode.ByWordWrapping
        fullName.numberOfLines = 0
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(fullName: String, shortName: String) {
        self.employeeImage.image = UIImage(named: "\(shortName).png")
        self.fullName.text = fullName
        self.shortName = shortName
    }

}
