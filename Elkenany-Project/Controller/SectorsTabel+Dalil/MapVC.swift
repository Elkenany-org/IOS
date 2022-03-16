//
//  MapVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 2/1/22.
//

import UIKit
import MapKit
import JGProgressHUD

class MapVC: UIViewController {

    var ooo = ""
    var eee = ""
   var companyTitle = ""
    
    //delegets and outlet
    var locationManager: CLLocationManager!
    @IBOutlet weak var mapp: MKMapView!
    var currentLocationStr = "Current location"
    var companyMo:CompanyDetailsDataModel?
    var id_company = 0


    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initialLoc = CLLocation(latitude: Double(UserDefaults.standard.string(forKey: "lan") ?? "") ?? 0.0, longitude: Double(UserDefaults.standard.string(forKey: "ll") ?? "") ?? 0.0)
        setStartingLocation(location: initialLoc, distance: 2000)
        addAnnotation()
        handelTap()
        FeatchCompanyInformations()
        print( "A7aaa" , UserDefaults.standard.string(forKey: "lan") ?? "")
        print( "A7a" , UserDefaults.standard.string(forKey: "ll") ?? "")


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

     
    }
    
    
    func FeatchCompanyInformations(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let idParameter = UserDefaults.standard.string(forKey: "IDDD") ?? ""
            let param = ["id": "\(idParameter)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            let companyDetailes = "https://elkenany.com/api/guide/company/?id="
            APIServiceForQueryParameter.shared.fetchData(url: companyDetailes, parameters: param, headers: headers, method: .get) { (success:CompanyDetailsDataModel?, filier:CompanyDetailsDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.companyMo = success
                    DispatchQueue.main.async { [self] in
//                       ooo = companyMo?.data?.latitude ?? ""
                        let lan = companyMo?.data?.latitude ?? ""
                        UserDefaults.standard.set(lan, forKey: "lan")
                        
//                       let lonn = companyMo?.data?.longitude ?? ""
                        let uuuu = companyMo?.data?.longitude ?? ""
                        UserDefaults.standard.set(uuuu, forKey: "ll")

//                        print(ooo)
                        let tit  = companyMo?.data?.name ?? ""
                        UserDefaults.standard.set(tit, forKey: "TIT")

//                        print("3333333", eee)
                       
                    }
                }
            }
        }
    }
    
    
    //MARK:- Handling Tabs of button clicks
    
    func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePop(){
        dismiss(animated: true)
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
        pin.coordinate = CLLocationCoordinate2D(latitude: Double(UserDefaults.standard.string(forKey: "lan") ?? "") ?? 0.0, longitude: Double(UserDefaults.standard.string(forKey: "ll") ?? "") ?? 0.0)
        pin.title =  UserDefaults.standard.string(forKey: "TIT") ?? " موقع الشركة"
        pin.subtitle = "My Pin Subtitle"
        mapp.addAnnotation(pin)
        print( "A7a" , UserDefaults.standard.string(forKey: "TIT") ?? "")

        
    }
    
}
