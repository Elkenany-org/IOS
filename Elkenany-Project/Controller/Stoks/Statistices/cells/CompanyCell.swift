//
//  CompanyCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/5/22.
//

import UIKit

class CompanyCell: UITableViewCell {

    @IBOutlet weak var popupImage: UIImageView!
    @IBOutlet weak var popupTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
