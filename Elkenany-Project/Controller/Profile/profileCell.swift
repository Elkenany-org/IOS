//
//  profileCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/26/21.
//

import UIKit

class profileCell: UICollectionViewCell {
    @IBOutlet weak var acountType: UILabel!
    @IBOutlet weak var ProfileName: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(image:String) {
        
        let url = URL(string:image)
        ProfileImage.kf.indicatorType = .activity
        ProfileImage.kf.setImage(with: url)
    }
    
    
    
}
