//
//  HeaderCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/4/21.
//

import UIKit

class HeaderCell: UICollectionReusableView {
    @IBOutlet weak var btnOulet: UIButton!
    @IBOutlet weak var moreOutLet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    var title: String?{
        didSet{
//            titleLabel.text = title
            btnOulet.setTitle(title, for: .normal)
        }
    }

    
    @IBAction func moreDetails(_ sender: Any) {
        
        if title == "القطاع" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vcc = storyboard.instantiateViewController(identifier: "BorsaHomeVC") as! BorsaHomeVC
            if let vc = self.next(ofType: UIViewController.self) {
                //            vcc.id_company = com_id
                
                vc.navigationController?.pushViewController(vcc, animated: true)
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vccc = storyboard.instantiateViewController(identifier: "NewsVC") as! NewsVC
                if let vc = self.next(ofType: UIViewController.self) {
                    //            vcc.id_company = com_id
                    
                    vc.navigationController?.pushViewController(vccc, animated: true)
                
                
            }
        

            
        }
    }
    }
    
    @IBAction func mainTitle(_ sender: Any) {
        
        if  btnOulet.titleLabel?.text == "القطاع" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vcc = storyboard.instantiateViewController(identifier: "BorsaHomeVC") as! BorsaHomeVC
            if let vc = self.next(ofType: UIViewController.self) {
                //            vcc.id_company = com_id
                
                vc.navigationController?.pushViewController(vcc, animated: true)
            }else if btnOulet.titleLabel?.text == "مقترح لك" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vccc = storyboard.instantiateViewController(identifier: "NewsVC") as! NewsVC
                if let vc = self.next(ofType: UIViewController.self) {
                    //            vcc.id_company = com_id
                    
                    vc.navigationController?.pushViewController(vccc, animated: true)
                
                
            }
        

            
        }
    }
    
    }
}


extension UIResponder {
    func nextMain<T:UIResponder>(ofType: T.Type) -> T? {
        let r = self.next
        if let r = r as? T ?? r?.next(ofType: T.self) {
            return r
        } else {
            return nil
        }
    }
}


