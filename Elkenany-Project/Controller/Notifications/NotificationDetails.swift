//
//  NotificationDetails.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 2/6/22.
//

import UIKit

class NotificationDetails: UIViewController {
    @IBOutlet weak var tiltle: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var notificationImage: UIImageView!
    
    var com_title = ""
    var com_desc = ""
    var com_Image = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tiltle.text = com_title
        desc.text = com_desc
        configureCell(image: com_Image)
        handelTap()
        
    }
    
    func configureCell(image:String) {
        
        let url = URL(string:image)
        notificationImage.kf.indicatorType = .activity
        notificationImage.kf.setImage(with: url)
        
        
    }

 
    @IBAction func desmiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
}
