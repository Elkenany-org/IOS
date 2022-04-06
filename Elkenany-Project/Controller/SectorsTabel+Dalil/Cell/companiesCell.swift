//
//  companiesCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/10/21.
//

import UIKit
import Cosmos

class companiesCell: UITableViewCell {

    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyDesc: UILabel!
    @IBOutlet weak var companyLocation: UILabel!
    @IBOutlet weak var companyImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func configureCell(data: MainData) {
        companyName.text = data.name ?? ""
        companyDesc.text = data.desc ?? ""
        companyLocation.text = data.address ?? ""
        let url = URL(string:data.image ?? "")
        companyImage.kf.indicatorType = .activity
        rating.rating = data.rate ?? 0
        companyImage.kf.setImage(with: url)
    
    }
    
    func configureCellLogos(data: loggs) {
        let url = URL(string:data.image ?? "")
        companyImage.kf.indicatorType = .activity
        companyImage.kf.setImage(with: url)
    
    }
    
//    @IBAction func toDetails(_ sender: Any) {
//        let vcc = UIStoryboard(name: "Main", bundle: nil)
////        vcc.instantiateViewController(identifier: "companyDetails") as companyDetails
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vcc = storyboard.instantiateViewController(identifier: "companyDetails") as! companyDetails
//        if let vc = self.nextttt(ofType: UIViewController.self) {
//            vc.navigationController?.pushViewController(vcc, animated: true)
//        }
//
//    }
//    
    
}


extension UIResponder {
    func nexttt<T:UIResponder>(ofType: T.Type) -> T? {
        let r = self.next
        if let r = r as? T ?? r?.next(ofType: T.self) {
            return r
        } else {
            return nil
        }
    }
}
