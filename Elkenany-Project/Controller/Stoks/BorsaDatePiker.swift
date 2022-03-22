//
//  BorsaDatePiker.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/25/21.
//

import UIKit


protocol BackDate {
    func backDateToMain(date:String)
}

class BorsaDatePiker: UIViewController {
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    var selectedDate:Date?
    var dateString:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let _dataStr = dateFormatter.string(from: DatePicker.date)
        return _dataStr
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handelTap()
        
    }
    
    fileprivate func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
    
    
    
    var completionHandler: ((String) -> String)?
    var dateDelgete:BackDate?
    
    
    
    
    
    
    @IBAction func selectedDate(_ sender: UIDatePicker) {
        self.selectedDate = sender.date
    }
    
    
    
    
    @IBAction func saveDate(_ sender: Any) {
        let dateForApi = dateString
//        print("==================== dateForApi \(dateForApi) ")
//        let datee = completionHandler?(dateForApi)
//        print( "complation =============================== \(datee ?? "")")
//        UserDefaults.standard.set(dateForApi, forKey: "Date_From_Picker")
        dateDelgete?.backDateToMain(date: dateForApi )
        dismiss(animated: true, completion: nil)
        
        
        
        
    }
    
    
    
}
