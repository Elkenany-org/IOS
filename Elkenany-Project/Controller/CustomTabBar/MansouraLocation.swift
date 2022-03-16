//
//  MansouraLocation.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/16/22.
//

import UIKit
import MapKit


class MansouraLocation: UIViewController {
    @IBOutlet weak var mapppppppppp: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let initialLoc = CLLocation(latitude: 31.02168380137456, longitude: 31.394367283909567)
        setStartingLocation(location: initialLoc, distance: 2000)
        addAnnotation()
    }
    

    func setStartingLocation(location:CLLocation , distance: CLLocationDistance){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapppppppppp.setRegion(region, animated: true)
        mapppppppppp.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 1000)
        mapppppppppp.setCameraZoomRange(zoomRange, animated: true)
        
        
        
    }
    
    
    
    func addAnnotation(){
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: 31.02168380137456, longitude: 31.394367283909567 )
        pin.title = "موقع الشركة بالمنصورة"
        pin.subtitle = "شركة الكناني للخدمات البيطرية والزراعية "
        mapppppppppp.addAnnotation(pin)

        
    }
    
    
    @IBAction func diiiiis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}
