//
//  SettingsVC.swift
//  Weather App
//
//  Created by Olivia Li on 2020-03-09.
//  Copyright © 2020 Olivia Li. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    var stringDate: String?

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmClicked(_ sender: Any) {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        let date = dateFormatter.date(from: selectedDate)
        let unix = Int(date!.timeIntervalSince1970)
        stringDate = String(unix)
        
        
        guard let vc = navigationController?.viewControllers[0] as! WeatherVC? else{
            return
        }
        
        vc.stringDate = stringDate
        self.navigationController?.popToRootViewController(animated: true)
    }
}
