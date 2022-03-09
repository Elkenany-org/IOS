//
//  onBoardingCellCollectionViewCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 11/21/21.
//

import UIKit

class onBoardingCell: UICollectionViewCell {

    @IBOutlet weak var descriotionLabel: UILabel!
//    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var toSigninVC: UIButton!{
        didSet{
            toSigninVC.layer.cornerRadius = 5

        }
    }
    @IBOutlet weak var logoImage: UIImageView!
    
    
    var actionBtnDidTap: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
      @IBAction func BTNAction(_ sender: Any) {
          actionBtnDidTap?()
      }
      
      
      func configuerSlide(slide:onboardingData){
        descriotionLabel.text = slide.description
        titleLabel.text = slide.title
        coverImage.image = slide.coverImage
        toSigninVC.backgroundColor = slide.buttonColor
        toSigninVC.setTitle(slide.buttontitle, for: .normal)
          
          
          }
      }



