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

        openGoogleMap()
    }
    
    
    func openGoogleMap() {
//         guard let lat = booking?.booking?.pickup_lat, let latDouble =  Double(lat) else {Toast.show(message: StringMessages.CurrentLocNotRight);return }
//
//         guard let long = booking?.booking?.pickup_long, let longDouble =  Double(long) else {Toast.show(message: StringMessages.CurrentLocNotRight);return }
        

        
          if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app

            if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(30.054403047637578),\(31.344001497493803)&directionsmode=driving") {
                        UIApplication.shared.open(url, options: [:])
               }}
          else {
                 //Open in browser
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(30.054403047637578),\(31.344001497493803)&directionsmode=driving") {
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
