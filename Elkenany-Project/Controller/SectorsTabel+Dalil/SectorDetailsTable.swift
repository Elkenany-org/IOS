//
//  SectorDetailsTable.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/7/21.
//

import UIKit

class SectorDetailsTable: UIViewController {

    //outlets and variables
    //title from selected cell sectore
    var titleFromCell = ""
    //title from home selected [first collection]
    var sectorFtomHome = ""
    //for navigation title 
    var titleeeee = ""
    var tabelData = ["البورصة اليومية", "دليل الشركات","الاخبار"]
    @IBOutlet weak var SectorDetailsTabel: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configuer cell
        setupUI()
        title =  titleeeee
    }
    


    func setupUI() {
        SectorDetailsTabel.dataSource = self
        SectorDetailsTabel.delegate = self
        SectorDetailsTabel.register(UINib(nibName: "SectorDetailsCell", bundle: nil), forCellReuseIdentifier: "SectorDetailsCell")
    }
    
}


//MARK:- tableView methods of sectors

extension SectorDetailsTable:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabelData.count 
    }
    
   
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectorDetailsCell") as! SectorDetailsCell
        cell.sectorDetailsTitle.text = tabelData[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let BorsaVC = (storyboard?.instantiateViewController(identifier: "BorsaHomeVC"))! as BorsaHomeVC
            BorsaVC.Sector = sectorFtomHome
            navigationController?.pushViewController(BorsaVC, animated: true)
            
        }else if indexPath.row == 1 {
            
            let GuideVC = (storyboard?.instantiateViewController(identifier: "CompanyGuideVC"))! as CompanyGuideVC
            GuideVC.sectoreTypeFromHome = sectorFtomHome
            navigationController?.pushViewController(GuideVC, animated: true)
            
        }else if indexPath.row == 2{
            
            let newsVC = (storyboard?.instantiateViewController(identifier: "NewsVC"))! as NewsVC
            newsVC.typeFromhome = sectorFtomHome
            navigationController?.pushViewController(newsVC, animated: true)
        }
        
        else {
            
         print("dev test")
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}
