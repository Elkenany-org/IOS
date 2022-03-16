//
//  CairoLocation.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/16/22.
//

import UIKit
import MapKit

class CairoLocation: UIViewController {

    @IBOutlet weak var mapp: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let initialLoc = CLLocation(latitude: 30.054403047637578, longitude: 31.344001497493803)
        setStartingLocation(location: initialLoc, distance: 3000)
        addAnnotation()
    }
    

    func setStartingLocation(location:CLLocation , distance: CLLocationDistance){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapp.setRegion(region, animated: true)
        mapp.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 1000)
        mapp.setCameraZoomRange(zoomRange, animated: true)
        
        
        
    }
    
    
    
    func addAnnotation(){
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: 30.054403047637578, longitude: 31.344001497493803)
        pin.title = "موقع الشركة بالقاهرة"
        pin.subtitle = "شركة الكناني لمجال البيطري والزراعي"
        mapp.addAnnotation(pin)

        
    }
    
    @IBAction func dddddiis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
}
