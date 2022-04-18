//
//  ChatCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 4/18/22.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var personImge: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var DateForMessage: UILabel!
    @IBOutlet weak var messageContent: UILabel!

    
    
    
    
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
        personImge.kf.indicatorType = .activity
        personImge.kf.setImage(with: url)
    }
    
    
}
