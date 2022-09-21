//
//  HomeVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 11/30/21.
//

import UIKit
import AVFoundation
import AVKit

class HomeVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var segmetMane: UISegmentedControl!
    @IBOutlet weak var secondContainerView: UIView! // sector
    @IBOutlet weak var firstContainerView: UIView!
    var userID = ""

    @IBOutlet weak var welcomeLabel: UIView!
    @IBOutlet weak var hedaerview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupSegment()
        

    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateEachLabel()

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func animateEachLabel() {
        
        UIView.animate(withDuration: 1.5, animations: {
              self.welcomeLabel.frame.origin.x = 10
          }) {_ in
              UIView.animate(withDuration: 1.5) {
                  self.welcomeLabel.frame.origin.x = 0
              }
          }
        
    }



    
    
    //MARK:- segment Handling color / bcColor / fonts
    fileprivate func SetupSegment() {
        if #available(iOS 13.0, *) {
            segmetMane.layer.borderColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
            segmetMane.selectedSegmentTintColor = #colorLiteral(red: 1, green: 0.5594755078, blue: 0.1821106031, alpha: 1)
            segmetMane.layer.borderWidth = 1
            segmetMane.layer.shadowRadius = 30
            let attr = [NSAttributedString.Key.font: UIFont(name: "Cairo", size: 14.0)!]
            UISegmentedControl.appearance().setTitleTextAttributes(attr, for: UIControl.State.normal)
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmetMane.setTitleTextAttributes(titleTextAttributes, for:.selected)
            
            let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
//            segmetMane.setBackgroundImage(UIImage(named: "Group 2803") for: .normal, barMetrics: .default)
            segmetMane.setBackgroundImage(UIImage(named: "Group 2803"), for: .selected, barMetrics: .compact)
//            segmetMane.setTitleTextAttributes(titleTextAttributes1, for:.normal)
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    
    //MARK:- segment Handling views
    @IBAction func SegmentSwitcher(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            firstContainerView.alpha = 1
            secondContainerView.alpha = 0
            sender.tintColor = .red
        }else if sender.selectedSegmentIndex == 1{
            firstContainerView.alpha = 0
            secondContainerView.alpha = 1
            
        }
        else{
            print("hello world")
        }
    }
    
}
