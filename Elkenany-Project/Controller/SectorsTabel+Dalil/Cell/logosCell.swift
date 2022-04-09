//
//  logosCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/13/21.
//

import UIKit
import Foundation
import Kingfisher

class logosCell: UICollectionViewCell {
//    @IBOutlet weak var logoImage: UIView!
    @IBOutlet weak var logooImage: UIImageView!
    var ModelData : SubSection?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    
    func configureImage(image:String) {
        
        let url = URL(string: image)
        logooImage.kf.indicatorType = .activity
//        self.userPhoto.backgroundColor = Colors.accent
        logooImage.kf.setImage(with: url )
    }
    

}
