//
//  aboooooout.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/16/22.
//

import UIKit

class aboooooout: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func toMappppp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcc = storyboard.instantiateViewController(identifier: "CairoLocation") as! CairoLocation
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
    
    
    @IBAction func toMaiiil(_ sender: Any) {
        let email = "Business@elkenany.com"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    @IBAction func phonnne(_ sender: Any) {
        callNumber(number: "\(+20222730688)")
    }
    
    @IBAction func mobilllle(_ sender: Any) {
        callNumber(number: "\(+201094940872)")
        
    }
    
    
    @IBAction func faxx(_ sender: Any) {
        callNumber(number: "\(+20502210179)")
        
    }
    
    
}



extension UIResponder {
    func next6<T:UIResponder>(ofType: T.Type) -> T? {
        let r = self.next
        if let r = r as? T ?? r?.next(ofType: T.self) {
            return r
        } else {
            return nil
        }
    }
}
