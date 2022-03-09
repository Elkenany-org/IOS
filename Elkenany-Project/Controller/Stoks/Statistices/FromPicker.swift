//
//  FromPicker.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/5/22.
//

import UIKit

//1
protocol DataBackProtocol {
    func dataBackFromPicker(dateFrom: String, currentDate: Date )

}


class FromPicker: UIViewController {

    @IBOutlet weak var fromPickerDate: UIDatePicker!
    var selectedDate:Date?
    var dateString:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-d"
        let _dataStr = dateFormatter.string(from: fromPickerDate.date)
        return _dataStr
    }
    
    //current Date
    var currrentDate:String{
        let dateFormatter = DateFormatter()
        fromPickerDate.date = Date()
//        fromPickerDate.timeZone = .none
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
//        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy-M-d"
        dateFormatter.locale = Locale.current

//        let currnt = dateFormatter.string(from: fromPickerDate.date)
        return dateFormatter.string(from: fromPickerDate.date)
    }
    
//    var currrentDate:Date{
//        let dateFormatter = DateFormatter()
//        fromPickerDate.date = Date()
//
////        fromPickerDate.timeZone = .none
////        dateFormatter.dateStyle = .short
//        dateFormatter.timeStyle = .none
//        dateFormatter.dateStyle = .medium
//        dateFormatter.dateFormat = "yyyy-M-d"
////        let currnt = dateFormatter.string(from: fromPickerDate.date)
//        return fromPickerDate.date
//    }
//
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        handelTap()
        
    }
    
    //2
    var DataBackDeleget:DataBackProtocol?
    var HelloWorld:statisticsInsideMain?
    var completionHandlerFromDate: ((String) -> String)?

    
    


    func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
    @IBAction func fromActio(_ sender: UIDatePicker) {
        self.selectedDate = sender.date
    }
    
    
    
    @IBAction func ChooseDateDone(_ sender: Any) {
        let dateForApi = dateString
        let currentDat = Date.tomorrow
        print("==================== dateForApi \(dateForApi) ")
        print("==================== CurrentForApi \(currentDat) ")

        
//        let datee = completionHandlerFromDate?(dateForApi)
//        print( "complation from =============================== \(datee ?? "")")
        //3
        DataBackDeleget?.dataBackFromPicker(dateFrom: dateForApi, currentDate: currentDat)
//        DataBackDeleget?.dataBackwithCurrentDate(currentDate: currentDat)
        UserDefaults.standard.set(dateForApi, forKey: "DATE_FROM")
        dismiss(animated: true, completion: nil)
    }
    
    
    

}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
