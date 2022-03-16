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
