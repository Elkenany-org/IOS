//
//  AdsViewController.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 4/19/22.
//

import UIKit

class AdsViewController: UIViewController {

    @IBOutlet weak var adsTitle: UITextField!
    @IBOutlet weak var adsPrice: UITextField!
    @IBOutlet weak var adsAdreess: UITextField!
    @IBOutlet weak var adsPhone: UITextField!
    @IBOutlet weak var adsDescription: UITextField!
    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var bt2: UIButton!
    @IBOutlet weak var bt4: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bt1.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        bt1.setImage(UIImage(named:"Checkmark"), for: .selected)
        bt2.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        bt2.setImage(UIImage(named:"Checkmark"), for: .selected)
        bt4.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        bt4.setImage(UIImage(named:"Checkmark"), for: .selected)
        // Do any additional setup after loading the view.
    }
    

    
    @IBOutlet var dissmiss: UIView!
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func radPhone(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    
    @IBAction func radMessage(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    
    @IBAction func radAll(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    @IBAction func updateImage(_ sender: Any) {
    }
    
    @IBAction func add(_ sender: Any) {
    }
    
    
    
}
