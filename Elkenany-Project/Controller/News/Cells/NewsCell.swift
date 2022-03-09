//
//  NewsCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/14/21.
//

import UIKit
import Kingfisher

class NewsCell: UICollectionViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(image:String) {
        let url = URL(string:image)
        newsImage.kf.indicatorType = .activity
        newsImage.kf.setImage(with: url)
    }

}
