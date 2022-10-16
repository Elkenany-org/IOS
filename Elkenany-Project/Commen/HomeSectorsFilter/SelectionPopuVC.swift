//
//  SelectionPopuVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/18/22.
//

import UIKit
import JGProgressHUD


class SelectionPopuVC: UIViewController {
    
    @IBOutlet weak var SelectedPopup: UITableView!
    var homeDataFilter:FirstFilterModel?
    var typppppe = ""
    var typeiddddd = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        GetFilterData()
        print("it presented ..... ")
    }
    
    
    
    fileprivate func setupUI() {
        SelectedPopup.delegate = self
        SelectedPopup.dataSource = self
        SelectedPopup.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")
    }
    
    
    
    
    //handel tap out to hide view
    func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
    
    
    //MARK:- get data of filter Popup
    func GetFilterData(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let SectoreFilterURL = "https://admin.elkenany.com/api/localstock/all-local-stock-sections?type="
            let tttyyyyppppeeee = UserDefaults.standard.string(forKey: "TYPE_FOR_FILTER" ) ?? "farm"
            let param = ["type": "\(tttyyyyppppeeee)"]
            APIServiceForQueryParameter.shared.fetchData(url: SectoreFilterURL, parameters: param, headers: nil, method: .get) { (success:FirstFilterModel?, filier:FirstFilterModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.homeDataFilter = success
                    DispatchQueue.main.async {
                        self.SelectedPopup.reloadData()
                        print("it get the data  ..... ")

                    }
                }
            }
        }
    }
    
    
    
    @IBAction func dissmis(_ sender: Any) {
        dismiss(animated: true, completion: nil )
    }
    
    
}


//MARK:- tableView Methodes
extension SelectionPopuVC:UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeDataFilter?.data?.sectors?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        cell.SectreTitle.text = homeDataFilter?.data?.sectors?[indexPath.row].name ?? ""
        let selecteddd = homeDataFilter?.data?.sectors?[indexPath.row].selected ?? 0

        
        if  selecteddd == 1{
            cell.imageSelected.image = #imageLiteral(resourceName: "check")
        }else{
            
            cell.imageSelected.image = #imageLiteral(resourceName: "square")

        }
        return cell
    }
    
    //selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        let selecteddd = homeDataFilter?.data?.sectors?[indexPath.row].selected ?? 0

        let typeeee = homeDataFilter?.data?.sectors?[indexPath.row].type ?? ""
        if  selecteddd == 1{
            cell.imageSelected.image = #imageLiteral(resourceName: "check")
        }else{
            
            cell.imageSelected.image = #imageLiteral(resourceName: "square")

        }
        self.typppppe = typeeee

        let ID_FOR_SEC = homeDataFilter?.data?.sectors?[indexPath.row].id ?? 0
        UserDefaults.standard.set(ID_FOR_SEC, forKey: "ID_FILTER")
        UserDefaults.standard.set(typeeee, forKey: "TYPE_FOR_FILTER")
        FilterAnimation.shared.filteranmation(vieww: view)
        dismiss(animated: true, completion: nil)
    }
    
    
    //Deselcte
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        let selecteddd = homeDataFilter?.data?.sectors?[indexPath.row].selected ?? 0
        if  selecteddd == 0{
            cell.imageSelected.image = #imageLiteral(resourceName: "square")
        }


    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
