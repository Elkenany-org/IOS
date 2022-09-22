//
//  NewsCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/14/21.
//

import UIKit
import Foundation
import Kingfisher
import Social

class NewsCell: UICollectionViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(image:String) {
        let url = URL(string:image)
        newsImage.kf.indicatorType = .activity
        newsImage.kf.setImage(with: url)
    }

    @IBAction func shareSocial(_ sender: Any) {
        
        
         //Setting description
        let firstActivityItem = "    يمكنك الاستمتاع بتجربة فريدة مع ابلكيشن الكناني رقم واحد في المجال البيطري والزراعي في الشرق الاوسط"
    
        // Setting url
        let secondActivityItem : NSURL = NSURL(string: "https://apps.apple.com/eg/app/%D8%A7%D9%84%D9%83%D9%86%D8%A7%D9%86%D9%8A/id1608815820")!
    
        // If you want to use an image
        let image : UIImage = UIImage(named: "AppIcon")!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
    
        // This lines is for the popover you need to show in iPad
        //                activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
    
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
    
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
    
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
    
        ]
    
        activityViewController.isModalInPresentation = true
//        present(activityViewController, animated: true, completion: nil)
    
        
  
        
    
        
    }
    
    
    
    
    
}
