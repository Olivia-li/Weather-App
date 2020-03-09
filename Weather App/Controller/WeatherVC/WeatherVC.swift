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
    @IBOutlet weak var windSpeed: UILabel!
    
    var forecast: Forecast!
    var locationManager: CLLocationManager?
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        determineCurrentLocation()
    
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
        precipProbability.text = "Precipitation Probability: \(forecast.precipProbability)"
        windSpeed.text = "Wind Speed: \(forecast.windSpeed) mph"
        temperature.text = "Temperature: \(forecast.temperature!)°F"
        apparentTemperature.text = "Feels like: \(forecast.apparentTemperature!)°F"
    }

}

