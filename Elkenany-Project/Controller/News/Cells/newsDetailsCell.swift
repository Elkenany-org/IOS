//
//  newsDetailsCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/14/21.
//

import UIKit
import WebKit

class newsDetailsCell: UICollectionViewCell {

    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsDesc: UILabel!
    @IBOutlet weak var newsDescription: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        newsDesc.attributedText = myMutableString

    }
    
    func configureCell(image:String) {
        
        let url = URL(string:image)
        Image.kf.indicatorType = .activity
        Image.kf.setImage(with: url)
        
        
    }

    

}

