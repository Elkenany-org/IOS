//
//  socialCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/2/22.
//

import UIKit

class socialCell: UITableViewCell {
    @IBOutlet weak var iconee: UIImageView!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
//        let tap = UITapGestureRecognizer(target: self, action: #selector(socialCell.tapFunction))
//        contact.isUserInteractionEnabled = true
//        contact.addGestureRecognizer(tap)
    }
    
//    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
//           print("tap working")
//       }
//    
    
    func configureImage(image:String) {
        
        let url = URL(string:image)
        iconee.kf.indicatorType = .activity
        iconee.kf.setImage(with: url)
    }
}
