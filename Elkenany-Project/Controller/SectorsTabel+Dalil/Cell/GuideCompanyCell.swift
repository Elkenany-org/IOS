//
//  GuideCompanyCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/7/21.
//

import UIKit
import Kingfisher

class GuideCompanyCell: UICollectionViewCell{
   
    
    var companyGuideModel:GuideCompaniesDataModel?
    var testModel:SubSection?
    
    
    @IBOutlet weak var companyTitle: UILabel!
    @IBOutlet weak var companiesCount: UILabel!
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    var arrayTest = [ #imageLiteral(resourceName: "down"), #imageLiteral(resourceName: "privacy-policy (2)") ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   
    }
    
    

    
    
    
    func configureCell(image:String) {
        let url = URL(string:image)
        companyImage.kf.indicatorType = .activity
        companyImage.kf.setImage(with: url)
    }
    
    
    

}
