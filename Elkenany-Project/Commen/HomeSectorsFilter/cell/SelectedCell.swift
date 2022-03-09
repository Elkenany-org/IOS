//
//  SelectedCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/18/22.
//

import UIKit

class SelectedCell: UITableViewCell {

    @IBOutlet weak var SectreTitle: UILabel!
    @IBOutlet weak var imageSelected: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
