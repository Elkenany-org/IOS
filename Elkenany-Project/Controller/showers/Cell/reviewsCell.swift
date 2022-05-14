//
//  reviewsCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/14/22.
//

import UIKit
import Cosmos

class reviewsCell: UITableViewCell {

    @IBOutlet weak var imageee: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var stat: UILabel!
    @IBOutlet weak var ratingVie: CosmosView!
    @IBOutlet weak var dateee: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func configureRating(reviewsDataaa: Review ) {
        ratingVie.rating = reviewsDataaa.rate ?? 0
        namelabel.text = reviewsDataaa.name ?? ""
        stat.text = reviewsDataaa.desc ?? ""
        email.text = reviewsDataaa.email ?? "" 
        dateee.text = reviewsDataaa.createdAt ?? ""
        
    }
    

    
}
