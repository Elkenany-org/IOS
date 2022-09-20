//
//  MagazineCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 9/20/22.
//

import UIKit
import Cosmos

class MagazineCell: UICollectionViewCell {

    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var magazineName: UILabel!
    
    @IBOutlet weak var magazineImage: UIImageView!
    
    @IBOutlet weak var descriptionnn: UILabel!
    @IBOutlet weak var locImage: UIImageView!
    @IBOutlet weak var locName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(image:String) {
        
        let url = URL(string:image)
        magazineImage.kf.indicatorType = .activity
        magazineImage.kf.setImage(with: url)
        
        
    }

}
