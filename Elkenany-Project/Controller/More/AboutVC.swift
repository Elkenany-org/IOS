//
//  AboutVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/27/21.
//

import UIKit
import Alamofire
import WebKit
import ProgressHUD

class AboutVC: UIViewController {

    var DataModelAbout: AboutUSModell?
    @IBOutlet weak var aboutUsLabel: UITextView!
    @IBOutlet weak var aboutusView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "عن التطبيق"
        FatchDataOfAboutUS()
        
    }
    
    
    
    func FatchDataOfAboutUS(){
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1) 
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        
        
        DispatchQueue.global(qos: .background).async {
            let newsDetailsURL = "https://admin.elkenany.com/api/about-us"
            APIServiceForQueryParameter.shared.fetchData(url: newsDetailsURL, parameters: nil, headers: nil, method: .get) { (NewsDetailssuccess:AboutUSModell?, NewsDetailsfilier:AboutUSModell?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = NewsDetailssuccess else {return}
                    self.DataModelAbout = success
                    DispatchQueue.main.async {
//                        aboutusView.loadHTMLString(DataModelAbout?., baseURL: nil)
                        self.aboutusView.loadHTMLString(self.DataModelAbout?.data?.about ?? "", baseURL: nil)
                        
                    }
                }
            }
        }
    }
   
}
