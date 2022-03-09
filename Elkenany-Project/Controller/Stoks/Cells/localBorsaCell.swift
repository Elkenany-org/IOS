//
//  localBorsaCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/25/21.
//

import UIKit

class localBorsaCell: UICollectionViewCell {

    @IBOutlet weak var proudectName: UILabel!
    @IBOutlet weak var priceOfProudect: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var weightStat: UILabel!
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
