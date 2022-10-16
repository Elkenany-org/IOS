//
//  FilterVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/6/22.
//

import UIKit
import JGProgressHUD


protocol FilterDone {
    func RunFilter(filter:())
}


class FilterVC: UIViewController {
  
    
    @IBOutlet weak var filterCollectionview: UICollectionView!
    var testPrortocol: String = ""
    var presentKey = ""
    var presentHomeFilter = ""
    var testhidenHome = ""
    var shortCutTest = ""
    var selectedType = ""
    let vcc:CompanyGuideVC? = nil
    //refrance for model
    var homeFilter:FirstFilterModel?
    let cellItems = ["القطاع", "الترتيب"]
    
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let testhiden = "keeey"
        let testhidenHomeeee = "home"
        
        if presentKey == testhiden {
            let selectedVC = storyboard?.instantiateViewController(withIdentifier: "SortByVC") as! SortByVC
            present(selectedVC, animated: true, completion: nil)
        }else if testhidenHome == testhidenHomeeee {

            print("hello world")
        }else{
            print("hello world")

        }
 
        
    }
    
    
    var RunFilterDeleget :FilterDone?
    
    fileprivate func setupUI() {
        //configuer UI
        filterCollectionview.delegate = self
        filterCollectionview.dataSource = self
        filterCollectionview.register(UINib(nibName: "filterHeader", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "filterHeader")
        self.filterCollectionview.register(UINib(nibName: "filterCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
        print("pro", testPrortocol)
    }
    
    
    
    
    //BTN used to send data -------------
    @IBAction func ConfirmFilter(_ sender: Any) {
        RunFilterDeleget?.RunFilter(filter: ())
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func dissmis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


//MARK:- methods of tableview 
extension FilterVC:UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
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
            cell.filterTitle.text = cellItems[indexPath.item]
            cell.filterImage.image = #imageLiteral(resourceName: "categories.png")
        case 1:
            cell.filterTitle.text = cellItems[indexPath.item]
            cell.filterImage.image = #imageLiteral(resourceName: "sort")
        default:
            return UICollectionViewCell()
        }
        return cell

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            
            let selectedVC = storyboard?.instantiateViewController(withIdentifier: "SelectionPopuVC") as! SelectionPopuVC
            present(selectedVC, animated: true, completion: nil)
            
        case 1:
            let selectedVC = storyboard?.instantiateViewController(withIdentifier: "SortByVC") as! SortByVC
            present(selectedVC, animated: true, completion: nil)
            
        default:
            print("not selected for any filter --------------")
        }
        
    }
    
    
}


