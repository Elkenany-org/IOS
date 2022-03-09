//
//  AboutVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/27/21.
//

import UIKit
import Alamofire
import WebKit
import JGProgressHUD

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
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let newsDetailsURL = "https://elkenany.com/api/about-us"
            APIServiceForQueryParameter.shared.fetchData(url: newsDetailsURL, parameters: nil, headers: nil, method: .get) { (NewsDetailssuccess:AboutUSModell?, NewsDetailsfilier:AboutUSModell?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
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
