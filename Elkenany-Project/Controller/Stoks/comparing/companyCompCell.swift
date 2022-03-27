//
//  companyCompCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/24/22.
//

import UIKit

class companyCompCell: UITableViewCell {
    
    @IBOutlet weak var CompImage: UIImageView!
    @IBOutlet weak var CompName: UILabel!
    @IBOutlet weak var CompType: UILabel!
    @IBOutlet weak var CompPrice: UILabel!
    @IBOutlet weak var CompDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
