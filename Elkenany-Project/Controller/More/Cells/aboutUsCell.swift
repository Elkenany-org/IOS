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
        
        let initialLoc = CLLocation(latitude:  30.314647812707346, longitude:  31.42632616216894)
        addAnnotation()
        print("lllllllll", initialLoc)
        setStartingLocation(location: initialLoc, distance: 3000)
    }
    
    func addAnnotation(){
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: 30.314647812707346, longitude:  31.42632616216894)
//        pin.title = companyTitle ?? "موقع الشركة"
        pin.subtitle = "My Pin Subtitle"
        mapppppp.addAnnotation(pin)
        
        
    }

    func setStartingLocation(location:CLLocation , distance: CLLocationDistance){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapppppp.setRegion(region, animated: true)
        mapppppp.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 1000)
        mapppppp.setCameraZoomRange(zoomRange, animated: true)
        
    }
    
    
    
    @IBAction func accessMap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcc = storyboard.instantiateViewController(identifier: "MapVC") as! MapVC
        if let vc = self.next(ofType: UIViewController.self) {
//            vcc.id_company = com_id
            vc.present(vcc, animated: true, completion: nil)
            
        }
        
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
