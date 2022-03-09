//
//  SectorsCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/4/21.
//

import UIKit
import Kingfisher

class SectorsCell: UICollectionViewCell {
    @IBOutlet weak var sectorImgCell: UIImageView!
    
    @IBOutlet weak var SecrorsName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(image:String) {
        
        let url = URL(string:image)
        sectorImgCell.kf.indicatorType = .activity
        sectorImgCell.kf.setImage(with: url)
        
        
    }

}
