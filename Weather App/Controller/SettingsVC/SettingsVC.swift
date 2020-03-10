//
//  SettingsVC.swift
//  Weather App
//
//  Created by Olivia Li on 2020-03-09.
//  Copyright © 2020 Olivia Li. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class SettingsVC: UIViewController {
    
    var stringDate: String?
    var locationManager = CLLocation()
    var coordinate: CLLocationCoordinate2D?

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var locationText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getCoordinate(_ address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
    func presentAlert(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func confirmClicked(_ sender: Any) {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        let date = dateFormatter.date(from: selectedDate)
        let unix = Int(date!.timeIntervalSince1970)
        stringDate = String(unix)
        
        if locationText.text! == "" {
            guard let vc = self.navigationController?.viewControllers[0] as! WeatherVC? else{
                return
            }
            vc.coordinate = nil
            vc.stringDate = self.stringDate
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        else{
            getCoordinate(locationText.text!) { coordinate, error in
                if let coordinate = coordinate, error == nil {
                    self.coordinate = coordinate
                    guard let vc = self.navigationController?.viewControllers[0] as! WeatherVC? else{
                        return
                    }
                    
                    vc.coordinate = self.coordinate
                    vc.stringDate = self.stringDate
                    self.navigationController?.popToRootViewController(animated: true)
                }
                else {
                    self.presentAlert("Please enter a valid location")
                    return
                }
            }
        }
    }
}
