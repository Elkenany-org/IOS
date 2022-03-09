//
//  NotificationCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/27/21.
//

import UIKit

class NotificationCell: UICollectionViewCell {
    @IBOutlet weak var notTitle: UILabel!
    
    @IBOutlet weak var notDescription: UILabel!
    
    
    @IBOutlet weak var notImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(image:String) {
        
        let url = URL(string:image)
        notImage.kf.indicatorType = .activity
        notImage.kf.setImage(with: url)
        
        
    }

}
