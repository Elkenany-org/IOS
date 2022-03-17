//
//  aboutUsCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/27/21.
//

import UIKit
import MapKit

class aboutUsCell: UICollectionViewCell {

    @IBOutlet weak var locationtitle: UILabel!
    
    @IBOutlet weak var locationDesc: UILabel!
    
    @IBOutlet weak var mapppppp: MKMapView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var fax: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    
    
    
    
    @IBAction func accessMap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcc = storyboard.instantiateViewController(identifier: "MansouraLocation") as! MansouraLocation
        if let vc = self.next(ofType: UIViewController.self) {
//            vcc.id_company = com_id
            vc.present(vcc, animated: true, completion: nil)
        }
    }
    
    
    func callNumber(number: String ) {
        
        guard let url = URL(string: "tel://\(number)") else {return}
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    @IBAction func toMaiiill(_ sender: Any) {
        let email = "Business@elkenany.com"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    @IBAction func phonnnee(_ sender: Any) {
        callNumber(number: "\(+20502210179)")
    }
    
    @IBAction func mobilllleee(_ sender: Any) {
        callNumber(number: "\(+201094940872)")
        
    }
    
    
    @IBAction func faxxxx(_ sender: Any) {
        callNumber(number: "\(+20502210279)")
        
    }
    
    

}












extension UIResponder {
    func next3<T:UIResponder>(ofType: T.Type) -> T? {
        let r = self.next
        if let r = r as? T ?? r?.next(ofType: T.self) {
            return r
        } else {
            return nil
        }
    }
}
