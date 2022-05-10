//
//  Constant.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/5/21.
//

import Foundation
import UIKit


let RegisterURL = "https://elkenany.com/api/register"
let LoginURL = "https://elkenany.com/api/login"
let HomeSectorsURL = "https://elkenany.com/api/home-sectors"
let HomeServiceURL = "https://elkenany.com/api/home-services"
let companyRating = "https://elkenany.com/api/guide/rating-company"



class puplicUsed{
    
    static let shared = puplicUsed() // Singltone
     let testSingltone = "urllllllllllllllll"

    
    
    
}


class FilterAnimation  {
    static let shared = FilterAnimation() // Singltone
    func filteranmation(vieww:UIView){
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        vieww.window!.layer.add(transition, forKey: nil)
    }

    
    
}
