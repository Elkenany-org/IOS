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
    

    @IBAction func toAddAds(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AdsViewController") as! AdsViewController
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
}
