//
//  CompaniesCollectionViewCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 8/28/22.
//

import UIKit
import Cosmos

class CompaniesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var rating: CosmosView! 
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyDesc: UILabel!
    @IBOutlet weak var companyLocation: UILabel!
    @IBOutlet weak var companyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    func configureCell(data: MainData) {
        companyName.text = data.name ?? ""
//        companyDesc.text = data.desc ?? ""
        companyLocation.text = data.address ?? ""
        let url = URL(string:data.image ?? "")
        companyImage.kf.indicatorType = .activity
        rating.rating = data.rate ?? 0
        companyImage.kf.setImage(with: url)
    
    }
    
//    func configureCellLogos(data: loggs) {
//        let url = URL(string:data.image ?? "")
//        companyImage.kf.indicatorType = .activity
//        companyImage.kf.setImage(with: url)
//    
//    }

}
