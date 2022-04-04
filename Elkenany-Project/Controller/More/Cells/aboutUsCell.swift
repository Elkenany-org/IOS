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
    
    
    //openLocation
    @IBAction func accessMap(_ sender: UIButton) {
        openGoogleMap()
    }
    
    
    //google map service  
    func openGoogleMap() {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
            if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(31.02168380137456),\(31.394367283909567)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:])
            }}
        else {
            //Open in browser
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(31.02168380137456),\(31.394367283909567)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }
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



//slecte in cell
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
