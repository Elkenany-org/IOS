//
//  testBorsaCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/3/22.
//

import UIKit

class testBorsaCell: UICollectionViewCell {

    @IBOutlet weak var proudectName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var changes: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var directOfPrice: UILabel!    
    @IBOutlet weak var statImagee: UIImageView!
    @IBOutlet weak var changeTwo: UILabel!
    
    @IBOutlet weak var kindd: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(image:String) {
        
        let url = URL(string:image)
        statImagee.kf.indicatorType = .activity
        statImagee.kf.setImage(with: url)
        
        
    }

}
