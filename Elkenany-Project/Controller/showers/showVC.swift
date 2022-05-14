//
//  showVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/14/22.
//

import UIKit

class showVC: UIViewController {
    
        @IBOutlet weak var segmentVieww: UISegmentedControl!
    @IBOutlet weak var firstIndex: UIView!
    @IBOutlet weak var secIndex: UIView!
    @IBOutlet weak var thiredIndex: UIView!
    @IBOutlet weak var fourthView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentVieww.selectedSegmentIndex = 0
        SetupSegment()

    }
    

    
    @IBAction func toShow(_ sender: Any) {
    }
    
    
    @IBAction func orderPlace(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "orderPlace") as! orderPlace
        present(vc, animated: true, completion: nil)
    }
    

    @IBAction func ratingShow(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "addRatingVC") as! addRatingVC
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func sharingShow(_ sender: Any) {
    }
    
    
    
    fileprivate func SetupSegment() {
        if #available(iOS 13.0, *) {
            //segmetMane.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            segmentVieww.layer.borderColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
            segmentVieww.selectedSegmentTintColor = #colorLiteral(red: 1, green: 0.5594755078, blue: 0.1821106031, alpha: 1)
            segmentVieww.layer.borderWidth = 1
            segmentVieww.layer.shadowRadius = 20
            let _font = UIFont.systemFont(ofSize: 14)
            UISegmentedControl.appearance()
                .setTitleTextAttributes([NSAttributedString.Key.font: _font], for: .normal)
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentVieww.setTitleTextAttributes(titleTextAttributes, for:.selected)
            
            let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
//            segmentVieww.setTitleTextAttributes(titleTextAttributes1, segmentVieww.normal)
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    
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
