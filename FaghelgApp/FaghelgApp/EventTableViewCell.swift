//
//  EventTableViewCell.swift
//  FaghelgApp
//
//  Created by Anders Ullnæss on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit
import CoreData

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var extraInfoView: UIView!
    
    // Constraints used for automatic resizing, by editing their values
    @IBOutlet weak var durationLabelBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var durationLabelTopSpace: NSLayoutConstraint!
    @IBOutlet weak var extraInfoViewHeight: NSLayoutConstraint!
    
    var durationLabelBottomSpaceConstaintConstant: CGFloat = 0
    var durationLabelTopSpaceConstraintConstant: CGFloat = 0
    var extraInfoViewHeightConstraintConstant: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.durationLabelBottomSpaceConstaintConstant = self.durationLabelBottomSpace.constant
        self.durationLabelTopSpaceConstraintConstant = self.durationLabelTopSpace.constant
        self.extraInfoViewHeightConstraintConstant = self.extraInfoViewHeight.constant
        
        // Rounding employee image
        personImage.layer.cornerRadius = personImage.frame.size.width / 2
        personImage.clipsToBounds = true
        personImage.layer.borderWidth = 1.0
        personImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.showExtraInfoView(false)
    }
    
    func setEvent(event: Event) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "HH:mm"
        timeLabel.text = dateStringFormatter.stringFromDate(event.start)
        if (event.hostNames != nil) {
            nameLabel.text = event.hostNames
        }
        else {
            nameLabel.text = nil
        }
        var durationSeconds:Double = event.end.timeIntervalSinceDate(event.start)
        var durationMinutes:Double = durationSeconds / 60
        var durationString: String? = String(format: "%.0f min", durationMinutes)
        if (durationString != nil) {
            durationLabel.text = durationString
        }
        else {
            durationLabel.text = nil
        }
        
        abstractLabel.text = event.desc
        titleLabel.text = event.title
        if (event.responsible == nil && event.hostNames != nil && event.hostNames.lowercaseString == "faggruppen") {
            var bgImage = getImage(event.hostNames.lowercaseString, profileImageUrl: "http://faghelg.s3-website-eu-west-1.amazonaws.com/" + event.hostNames.lowercaseString + ".png");
            personImage.image = bgImage
        }
        else if (event.responsible != nil && event.responsible?.profileImageUrl != nil && event.responsible?.shortName != nil) {
            var bgImage = getImage(event.responsible!.shortName!, profileImageUrl: event.responsible!.profileImageUrl!);
            personImage.image = bgImage
        }
        else {
            personImage.image = UIImage(named: "ukjent");
        }
    }
    
    func showExtraInfoView(show: Bool) {
        if (show) {
            self.extraInfoViewHeight.constant = self.extraInfoViewHeightConstraintConstant
            // dipatch_after ensures that there's a small delay before the constraints are updated,
            // which for some reason prevents constraint validation errors .
            // It probably allows the height constraint to fully take effect, since making the spacing between elements in a
            // 0 height view would cause validation errors.
            dispatch_after(1, dispatch_get_main_queue(), {
                self.durationLabelBottomSpace.constant = self.durationLabelBottomSpaceConstaintConstant
                self.durationLabelTopSpace.constant = self.durationLabelTopSpaceConstraintConstant
            });
        } else {
            self.durationLabelBottomSpace.constant = 0
            self.durationLabelTopSpace.constant = 0
            self.extraInfoViewHeight.constant = 0
        }
        
        self.extraInfoView.hidden = !show
    }
    
    func getImage(shortName: String, profileImageUrl: String) -> UIImage {
        var managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        
        var nsFetchRequest: NSFetchRequest = NSFetchRequest(entityName: "BildeDao")
        nsFetchRequest.includesPendingChanges = false
        nsFetchRequest.predicate = NSPredicate(format: "shortName = %@", shortName)
        var existingBildeDaos: NSArray = managedObjectContext?.executeFetchRequest(nsFetchRequest, error: nil) as NSArray!
        var existingBildeDao: BildeDao? = existingBildeDaos.firstObject as? BildeDao
        
        if (existingBildeDao != nil) {
            return UIImage(data: existingBildeDao!.imageData)
        }
        
        var newBildeDao: BildeDao
        newBildeDao = getImageFromWeb(profileImageUrl, shortName: shortName, managedObjectContext: managedObjectContext!)
        newBildeDao.save()

        return UIImage(data: newBildeDao.imageData)
    }
    
    func getImageFromWeb(profileImageUrl: String, shortName: String, managedObjectContext: NSManagedObjectContext) -> BildeDao {
        let url = NSURL.URLWithString(profileImageUrl);
        var err: NSError? = nil
        
        var imageData :NSData = NSData.dataWithContentsOfURL(url,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)
        
        var bildeDao: BildeDao = BildeDao(entity: NSEntityDescription.entityForName("BildeDao", inManagedObjectContext: managedObjectContext)!, insertIntoManagedObjectContext: managedObjectContext)
        
        bildeDao.shortName = shortName
        bildeDao.imageData = imageData
        
        return bildeDao
    }
}
