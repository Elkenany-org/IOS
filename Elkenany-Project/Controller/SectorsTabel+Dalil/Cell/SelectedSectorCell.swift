//
//  SelectedSectorCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/7/21.
//

import UIKit

class SelectedSectorCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedSector: UILabel!
    @IBOutlet weak var contView: UIView!
 
    
    @IBOutlet weak var cooo: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cooo.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
    }
    override var isSelected: Bool {
        didSet {
            
            cooo.backgroundColor = isSelected ? #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1) : #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
        }
    }

}
