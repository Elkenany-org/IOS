//
//  showVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/14/22.
//

import UIKit

class showVC: UIViewController {
    
    //outlet
    @IBOutlet weak var segmentVieww: UISegmentedControl!
    @IBOutlet weak var goingTitle: UIButton!
    @IBOutlet weak var notGoingTitle: UIButton!
    @IBOutlet weak var firstIndex: UIView!
    @IBOutlet weak var secIndex: UIView!
    @IBOutlet weak var thiredIndex: UIView!
    @IBOutlet weak var fourthView: UIView!
    
    
    
    //models
    var gingornotModel:AddPlaces?
    var showesModel:ShowesHome?
    var subShowesModel:[showesHomeData] = []
    var idFromSh = 0
    var testId = ""
    //vars
    var linkeeeee = ""
    var acceptedTitle  = ""
    var acceptedId = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = acceptedTitle
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetupSegment()
        ReviwesServices()
        segmentVieww.selectedSegmentIndex = 0
        firstIndex.alpha = 1
        secIndex.alpha = 0
        thiredIndex.alpha = 0
        fourthView.alpha = 0
        
    }
    
    
    
    //MARK: not going services
    @IBAction func notgoing(_ sender: Any) {
        let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
        
        if isloggineIn {
            NotGoingService()
        }else{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "popupToSignIN") as? popupToSignIN {
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true, completion: nil)}}}
    
    
    
    //MARK: Goooooooooing
    @IBAction func going(_ sender: Any) {
        let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
        
        if isloggineIn {
            GoingService()
        }else{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "popupToSignIN") as? popupToSignIN {
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true, completion: nil)}}}
    
    
    
    //MARK: Order place btn
    @IBAction func orderPlace(_ sender: Any) {
        let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
        
        if isloggineIn {
            let vc = storyboard?.instantiateViewController(withIdentifier: "orderPlace") as! orderPlace
            present(vc, animated: true, completion: nil)
        }else{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "popupToSignIN") as? popupToSignIN {
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true, completion: nil)}}}
    
    
    
    //rating
    @IBAction func ratingShow(_ sender: Any) {
        let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
        
        if isloggineIn {
            let vc = storyboard?.instantiateViewController(withIdentifier: "addRatingVC") as! addRatingVC
            present(vc, animated: true, completion: nil)
        }else{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "popupToSignIN") as? popupToSignIN {
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true, completion: nil)}}}
    
    
    
    //share
    @IBAction func sharingShow(_ sender: Any) {
        let firstActivityItem = "    يمكنك الاستمتاع بتجربة فريدة مع ابلكيشن الكناني رقم واحد في المجال البيطري والزراعي في الشرق الاوسط"
        let secondActivityItem : NSURL = NSURL(string: "\(linkeeeee)")!
        let image : UIImage = UIImage(named: "AppIcon")!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    
    //segement setup
    fileprivate func SetupSegment() {
        if #available(iOS 13.0, *) {
            
            segmentVieww.layer.borderColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
            segmentVieww.selectedSegmentTintColor = #colorLiteral(red: 1, green: 0.5594755078, blue: 0.1821106031, alpha: 1)
            segmentVieww.layer.borderWidth = 1
            segmentVieww.layer.shadowRadius = 20
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentVieww.setTitleTextAttributes(titleTextAttributes, for:.selected)
            let attr = [NSAttributedString.Key.font: UIFont(name: "Cairo", size: 13.0)!]
            UISegmentedControl.appearance().setTitleTextAttributes(attr, for: UIControl.State.normal)
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    //reviwes
    func ReviwesServices(){
        let parm = ["type" : "poultry"]
        DispatchQueue.global(qos: .background).async {
            let url = "https://elkenany.com/api/showes/all-showes?type=&sort="
            
            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:ShowesHome?, filier:ShowesHome?, error) in
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    let successDataa = success?.data?.data ?? []
                    self.subShowesModel.append(contentsOf: successDataa)
                    DispatchQueue.main.async {
                        for i in self.subShowesModel  {
                            print(i.deebLink ?? "")
                            self.linkeeeee = i.deebLink ?? ""
                        }
                    }
                }
            }
        }
    }
    
    
    
    //going
    func GoingService(){
        let idShow = UserDefaults.standard.string(forKey: "IDDD") ?? ""
        let parm = ["show_id" : "\(idShow)"]
        DispatchQueue.global(qos: .background).async {
            let url = "https://elkenany.com/api/showes/one-show-going"
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""
            let headers = ["Authorization": "Bearer \(api_token)" ]
            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: headers, method: .post) { (success:AddPlaces?, filier:AddPlaces?, error) in
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    guard let success = success else {return}
                    self.gingornotModel = success
                    DispatchQueue.main.async {
                        print("yeeeeeeeees")
                        self.notGoingTitle.isHidden = false
                        self.goingTitle.isHidden = true
                        
                        let alert = UIAlertController(title: "مرحبا", message: "تم تحديد الذهاب بنجاح", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "تم", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
            }
        }
    }
    
    
    //notGoing
    func NotGoingService(){
        let idShow = UserDefaults.standard.string(forKey: "IDDD") ?? ""
        let parm = ["show_id" : "\(idShow)"]
        DispatchQueue.global(qos: .background).async {
            let url = "https://elkenany.com/api/showes/one-show-notgoing"
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""
            let headers = ["Authorization": "Bearer \(api_token)" ]
            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: headers, method: .post) { (success:AddPlaces?, filier:AddPlaces?, error) in
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    guard let success = success else {return}
                    self.gingornotModel = success
                    DispatchQueue.main.async {
                        print("nooooooo")
                        self.notGoingTitle.isHidden = true
                        self.goingTitle.isHidden = false
                        let alert = UIAlertController(title: "مرحبا", message: " تم الغاءالذهاب بنجاح ", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "تم", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
            }
        }
    }
    
    
    //MARK: present views
    @IBAction func SegmentSwitcher(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            firstIndex.alpha = 1
            secIndex.alpha = 0
            thiredIndex.alpha = 0
            fourthView.alpha = 0
        }else if sender.selectedSegmentIndex == 1{
            firstIndex.alpha = 0
            secIndex.alpha = 1
            thiredIndex.alpha = 0
            fourthView.alpha = 0
            
        }else if sender.selectedSegmentIndex == 2{
            firstIndex.alpha = 0
            secIndex.alpha = 0
            thiredIndex.alpha = 1
            fourthView.alpha = 0
            
        }else if sender.selectedSegmentIndex == 3{
            firstIndex.alpha = 0
            secIndex.alpha = 0
            thiredIndex.alpha = 0
            fourthView.alpha = 1
        }
        else{
            print("hello world")
        }
    }
    
    
}
