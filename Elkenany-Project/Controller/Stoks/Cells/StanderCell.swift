//
//  StanderCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/3/22.
//

import UIKit

class StanderCell: UICollectionViewCell {

    @IBOutlet weak var proudectLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var statImage: UIImageView!
    
    @IBOutlet weak var changeTwo: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(image:String) {
        
        let url = URL(string:image)
        statImage.kf.indicatorType = .activity
        statImage.kf.setImage(with: url)
        
        
    }

}
