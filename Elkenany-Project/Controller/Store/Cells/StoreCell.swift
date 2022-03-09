//
//  StoreCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/19/21.
//

import UIKit

class StoreCell: UICollectionViewCell {
    @IBOutlet weak var storeBanner: UIView!
    
    @IBOutlet weak var imagee: UIImageView!
    @IBOutlet weak var number: UILabel!
    
    @IBOutlet weak var titlee: UILabel!
    
    @IBOutlet weak var dateee: UILabel!
    @IBOutlet weak var location: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    
    func configureCell(image:String) {
        let url = URL(string:image)
        imagee.kf.indicatorType = .activity
        imagee.kf.setImage(with: url)
    }
    
    
    
}
