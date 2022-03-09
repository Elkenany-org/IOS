//
//  successCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/5/21.
//

import UIKit
import Kingfisher

class successCell: UICollectionViewCell {

    @IBOutlet weak var sucessMembers: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCell(image:String) {
        let url = URL(string:image)
        sucessMembers.kf.indicatorType = .activity
        sucessMembers.kf.setImage(with: url)
    }

}
