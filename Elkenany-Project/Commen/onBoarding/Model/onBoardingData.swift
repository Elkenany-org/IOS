//
//  onBoardingData.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 11/21/21.
//

import Foundation
import UIKit

struct onboardingData {
    var title: String
    var description:String
    var coverImage:UIImage
    var buttonColor:UIColor
    var buttontitle:String
    
    var colo:UIColor = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
    
    
//
//    static var onBoardingSlider:[onboardingData] = [(.init(title: "The Best choise to you , save your money and get order easily  ", animationName: "67225-delivery-food-interaction", buttonColor: .systemOrange, buttontitle: "Next")),(.init(title: "Stay at Home and get your order , let's chosse ", animationName: "58352-delivery-boy", buttonColor: .systemBlue, buttontitle: "Gooooo")),(.init(title: "The Best choise to you , save your money and get order easily  ", animationName: "67225-delivery-food-interaction", buttonColor: .systemOrange, buttontitle: "Next"))]
    
    
    static var onBoardingSlider:[onboardingData] = [(.init(title: "الكناني اسهل ", description: "هتقدر توصل لمعلومات وشركات المجال البيطري والزراعي مع الكناني بشكل اسهل ", coverImage: #imageLiteral(resourceName: "Artboard 16-1"), buttonColor:#colorLiteral(red: 1, green: 0.5594755078, blue: 0.1821106031, alpha: 1), buttontitle: "المزيد")),
                                                    
        (.init(title: "الكناني اسرع", description: "هتقدر توصل لمعلومات وشركات المجال البيطري والزراعي مع الكناني بشكل اسهل ", coverImage:#imageLiteral(resourceName: "Artboard 17") , buttonColor: #colorLiteral(red: 1, green: 0.5594755078, blue: 0.1821106031, alpha: 1), buttontitle: "المزيد")),
        
        
       (.init(title: "الكناني آضمن", description: "هتقدر توصل لمعلومات وشركات المجال البيطري والزراعي مع الكناني بشكل اسهل ", coverImage: #imageLiteral(resourceName: "Artboard 18"), buttonColor: #colorLiteral(red: 0, green: 0.2823529412, blue: 0.2, alpha: 1), buttontitle: "تسجيل الدخول"))]
    
    
}
