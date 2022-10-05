//
//  SliderCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/19/21.
//

import UIKit

class SliderCell: UICollectionViewCell {
    @IBOutlet weak var bannerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(image:String) {
        let url = URL(string:image)
        bannerImage.kf.indicatorType = .activity
        bannerImage.kf.setImage(with: url)
    }
    
}
