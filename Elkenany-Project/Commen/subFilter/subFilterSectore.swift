//
//  subFilterSectore.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/25/22.
//

import UIKit
import JGProgressHUD

class subFilterSectore: UIViewController {
    
    @IBOutlet weak var sectoreTV: UITableView!
    var sectoreModel:SubGuideFilter?
    var presntKEY = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        GetFilterDataForSectore()
    }
    
    fileprivate func setupUI() {
        sectoreTV.delegate = self
        sectoreTV.dataSource = self
        sectoreTV.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")
    }
    
    
    func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //MARK:- get data of filter Popup
    func GetFilterDataForSectore(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
                  ///data not real
            let param = ["sector_id": "\(1)"]
            let subGuideFilterURL = "https://admin.elkenany.com/api/guide/filter-guide-companies?sector_id="
            APIServiceForQueryParameter.shared.fetchData(url: subGuideFilterURL, parameters: param, headers: nil, method: .get) { (success:SubGuideFilter?, filier:SubGuideFilter?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.sectoreModel = success
                    DispatchQueue.main.async {
                        self.sectoreTV.reloadData()
                        
                    }
                }
            }
        }
    }
    
    
 
    
    
    
}

//MARK:- tableView Methodes
extension subFilterSectore:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectoreModel?.data?.sectors?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        cell.SectreTitle.text = sectoreModel?.data?.sectors?[indexPath.row].name ?? ""
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let SectionVC = storyboard?.instantiateViewController(identifier: "subFilterSection") as? subFilterSection {
            let sec_id = sectoreModel?.data?.sectors?[indexPath.row].id ?? 0
            let sec_type = sectoreModel?.data?.sectors?[indexPath.row].type ?? ""
            SectionVC.secId = sec_id
            /// save idddddddddd
            UserDefaults.standard.set(sec_id, forKey: "FILTER_SEC_ID")
            UserDefaults.standard.set(sec_type, forKey: "FILTER_SEC_TYPE")
            FilterAnimation.shared.filteranmation(vieww: view)
            dismiss(animated: true, completion: nil)
//            if (presntKEY == "show") || (presntKEY == "magazine") {
//
//            }else{
//                self.present(SectionVC, animated: true, completion: nil)
//
//            }
        
        }
    }
    
}



