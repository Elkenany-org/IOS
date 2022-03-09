//
//  TabBarVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/4/21.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selectedIndex = 4
        
        
      
    }
    
   
   
    override func viewWillLayoutSubviews() {
        var newTabBarFrame = tabBar.frame

        let newTabBarHeight: CGFloat = 100
        newTabBarFrame.size.height = newTabBarHeight
        newTabBarFrame.origin.y = self.view.frame.size.height - newTabBarHeight

        tabBar.frame = newTabBarFrame
    }
    
  
}

class CustomTabBar : UITabBar {

@IBInspectable var height: CGFloat = 65.0

override open func sizeThatFits(_ size: CGSize) -> CGSize {
    guard let window = UIApplication.shared.keyWindow else {
        return super.sizeThatFits(size)
    }
    var sizeThatFits = super.sizeThatFits(size)
    if height > 0.0 {

        if #available(iOS 11.0, *) {
            sizeThatFits.height = height + window.safeAreaInsets.bottom
        } else {
            sizeThatFits.height = height
        }
    }
    return sizeThatFits
}
}
