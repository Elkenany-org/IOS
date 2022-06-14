//
//  sliderCellShow.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 6/13/22.
//

import UIKit

class sliderCellShow: UICollectionViewCell {

    @IBOutlet weak var sliderImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureImage(image:String) {
        
        let url = URL(string: image)
        sliderImage.kf.indicatorType = .activity
//        self.userPhoto.backgroundColor = Colors.accent
        sliderImage.kf.setImage(with: url )
    }
    
}
