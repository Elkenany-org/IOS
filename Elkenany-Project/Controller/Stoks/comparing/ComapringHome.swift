//
//  ComapringHome.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/24/22.
//

import UIKit


protocol ComapringProtocol {
    func RunComparingDone(filter:())

}


class ComapringHome: UIViewController {

    @IBOutlet weak var comparingCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    fileprivate func setupUI() {
        //configuer UI
        comparingCV.delegate = self
        comparingCV.dataSource = self
        comparingCV.register(UINib(nibName: "filterHeader", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "filterHeader")
        self.comparingCV.register(UINib(nibName: "filterCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
    }
    
    
    var RunComparingDelegetsInStoke :ComapringProtocol?

    
    
    @IBAction func applyComp(_ sender: Any) {
        if let comVC = storyboard?.instantiateViewController(identifier: "ComparingDone") as? ComparingDone {
            comVC.modalPresentationStyle = .fullScreen
            self.present(comVC, animated: true, completion: nil)

        }
        
    }
    
    
    
    
}


//MARK:- methods of tableview
extension ComapringHome:UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! filterCell
        switch indexPath.item{
        case 0:
//            cell.filterTitle.text = cellItems[indexPath.item]
            cell.filterTitle.text = "الشركات"
            cell.filterImage.image = #imageLiteral(resourceName: "office")
        case 1:
            cell.filterTitle.text = "الاصناف"
            cell.filterImage.image = #imageLiteral(resourceName: "sort")
        default:
            return UICollectionViewCell()
        }
        return cell

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            
            let selectedVC = storyboard?.instantiateViewController(withIdentifier: "ComparingComp") as! ComparingComp
            present(selectedVC, animated: true, completion: nil)
            
        case 1:
            
            let selectedVC = storyboard?.instantiateViewController(withIdentifier: "ComparingItems") as! ComparingItems
            present(selectedVC, animated: true, completion: nil)
            
        default:
            print("not selected for any filter --------------")
        }
        
    }
    
    
}
