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
    var subShowesModel:[ShowesDataModel] = []
    var idFromSh = 0
    var testId = ""
    //vars
    var linkeeeee = ""
    var acceptedTitle  = ""
    var acceptedId = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = acceptedTitle
//       title = UserDefaults.standard.string(forKey: "TitleSerch")
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetupSegment()
        segmentVieww.selectedSegmentIndex = 0
        firstIndex.alpha = 1
        secIndex.alpha = 0
        thiredIndex.alpha = 0
        fourthView.alpha = 0
        
    }
    
    

    //segement setup
    fileprivate func SetupSegment() {
        if #available(iOS 13.0, *) {
            segmentVieww.selectedSegmentTintColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.2, alpha: 1)
            segmentVieww.layer.borderWidth = 0
            segmentVieww.layer.shadowRadius = 20
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            segmentVieww.setTitleTextAttributes(titleTextAttributes, for:.selected)
            let attr = [NSAttributedString.Key.font: UIFont(name: "Cairo", size: 13.0)!]
            UISegmentedControl.appearance().setTitleTextAttributes(attr, for: UIControl.State.normal)

        } else {
            // Fallback on earlier versions
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
