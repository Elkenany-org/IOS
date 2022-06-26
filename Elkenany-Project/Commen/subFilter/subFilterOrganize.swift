//
//  subFilterOrganize.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/25/22.
//

import UIKit
import JGProgressHUD

class subFilterOrganize: UIViewController {
    
    @IBOutlet weak var OrganizeTV: UITableView!
    var OrganizeModel:SubGuideFilter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        GetFilterData()
    }
    
    
    fileprivate func setupUI() {
        OrganizeTV.delegate = self
        OrganizeTV.dataSource = self
        OrganizeTV.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")
    }
    
    
    
    
    fileprivate func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
    @IBAction func dissmis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func GetFilterData(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
            ///data not real
            let param = ["sector_id": "\(1)"]
            let subGuideFilterURL = "https://elkenany.com/api/guide/filter-guide-companies?sector_id="
            print("============== request \(param)")
            APIServiceForQueryParameter.shared.fetchData(url: subGuideFilterURL, parameters: param, headers: nil, method: .get) { (success:SubGuideFilter?, filier:SubGuideFilter?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.OrganizeModel = success
                    DispatchQueue.main.async {
                        self.OrganizeTV.reloadData()
                        
                    }
                }
            }
        }
    }
    
    
}

//MARK:- tableView Methodes
extension subFilterOrganize:UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrganizeModel?.data?.sort?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        cell.SectreTitle.text = OrganizeModel?.data?.sort?[indexPath.row].name ?? ""
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = OrganizeModel?.data?.sort?[indexPath.row].value ?? 0
        let sortName = OrganizeModel?.data?.sort?[indexPath.row].name ?? ""
        UserDefaults.standard.set(value, forKey: "FILTER_SORT_VAL")
        UserDefaults.standard.set(sortName, forKey: "SORT_TITLE")

        
        FilterAnimation.shared.filteranmation(vieww: view)
        dismiss(animated: true, completion: nil)
    }
    
    
}
