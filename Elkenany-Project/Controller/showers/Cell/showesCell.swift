//
//  showesCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/12/22.
//

import UIKit
import Cosmos

class showesCell: UITableViewCell {

    @IBOutlet weak var showsImage: UIImageView!
    
    @IBOutlet weak var showesName: UILabel!
    @IBOutlet weak var countryName: UILabel!

    @IBOutlet weak var showesDate: UILabel!
    
    @IBOutlet weak var showesDescription: UILabel!
    
    @IBOutlet weak var showesView: UILabel!
    
    @IBOutlet weak var starRating: UIView!
    
    @IBOutlet weak var RatingVi: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func configureCell(image:String) {
        let url = URL(string:image)
        showsImage.kf.indicatorType = .activity
        showsImage.kf.setImage(with: url)
    }
    
    
    
//    
//    func configureRating(ddd: showesHomeData ) {
//        RatingVi.rating = ddd.rate ?? 0
//    
//    }
//    
    
    
}
