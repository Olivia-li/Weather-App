//
//  ViewController.swift
//  Weather App
//
//  Created by Olivia Li on 2020-03-08.
//  Copyright © 2020 Olivia Li. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController {
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var apparentTemperature: UILabel!
    @IBOutlet weak var precipProbability: UILabel!
    @IBOutlet weak var precipType: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    
    var forecast: Forecast!
    var test = "https://api.darksky.net/forecast/redacted/37.785834,-122.406417"
    
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        determineCurrentLocation()
        getApi(test)
       
    
    }
    
    func getApi(_ sURL: String) {
        ApiManager.fetchWeather(sURL, { data in
            self.forecast = data
            DispatchQueue.main.async {
                self.reload()
                print("run")
            }
        })
    }
    
    func reload(){
        summary.text = forecast.summary
    }

}

