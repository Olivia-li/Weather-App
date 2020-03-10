//
//  ForecastVC.swift
//  Weather App
//
//  Created by Olivia Li on 2020-03-09.
//  Copyright © 2020 Olivia Li. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastVC: UIViewController {
    
    var forecast: [Forecast]!
    var locationManager: CLLocationManager?
    var url: String?
    @IBOutlet weak var mondayHigh: UILabel!
    @IBOutlet weak var tuesdayHigh: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        determineCurrentLocation()

        // Do any additional setup after loading the view.
    }
    
    func getApi(_ sURL: String) {
        ApiManager.fetchForecast(sURL, { data in
            self.forecast = data
            DispatchQueue.main.async {
                self.reload()
                print("run")
            }
        })
    }
    
    func getDate(unix: Double) -> NSDate{
        return NSDate(timeIntervalSince1970: unix)
    }
    
    func reload(){
        mondayHigh.text = "\(getDate(unix: forecast[0].time))"
        tuesdayHigh.text = forecast[1].summary
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
