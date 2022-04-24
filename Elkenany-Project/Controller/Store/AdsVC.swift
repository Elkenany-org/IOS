//
//  AdsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/18/21.
//

import UIKit

class AdsVC: UIViewController {

    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var AdssCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    
    

    
    func testLogin(){
        
        var isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
        if isloggineIn {
            let vc = storyboard?.instantiateViewController(withIdentifier: "AdsViewController") as! AdsViewController
            self.present(vc, animated: true, completion: nil)
            

        }else{
                    if let vc = storyboard?.instantiateViewController(identifier: "ValidaitionViewController") as? ValidaitionViewController {
                        self.present(vc, animated: true, completion: nil)
                    }
            
        }

        
        
    }
    

    @IBAction func toAddAds(_ sender: Any) {

        testLogin()
    
    
}
}
