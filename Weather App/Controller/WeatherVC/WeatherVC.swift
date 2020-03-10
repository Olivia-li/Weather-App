//
//  ViewController.swift
//  Weather App
//
//  Created by Olivia Li on 2020-03-08.
//  Copyright © 2020 Olivia Li. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation



class WeatherVC: UIViewController {
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var apparentTemperature: UILabel!
    @IBOutlet weak var precipProbability: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var weather: Forecast!
    var forecast: [Forecast] = []
    
    var locationManager: CLLocationManager?
    var url: String?
    var stringDate: String?
    var coordinate: CLLocationCoordinate2D?
    var city: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        determineCurrentLocation()
    }
    
    func unixToSpeech(unix: Double) -> String{
        let nsdate = NSDate(timeIntervalSince1970: unix)
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day , .month , .year], from: nsdate as Date)
        let string = "\(monthAsString(date: nsdate as Date)) \(components.day!) \(components.year!)"
        return string
    }
    
    func monthAsString(date: Date) -> String {
            let df = DateFormatter()
            df.setLocalizedDateFormatFromTemplate("MMMM")
            return df.string(from: date)
    }
    
    func getSpeech(){
        var speechString: String?
        if let stringDate = self.stringDate{
            speechString = "On \(unixToSpeech(unix: weather.time)) in \(self.city!) it was \(weather.temperature!) degrees and \(weather.summary)"
        }
        else{
            speechString = "Currently in \(self.city!) it is \(weather.temperature!) degrees and \(weather.summary)"
            print("No date")
        }
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: speechString!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        synthesizer.speak(utterance)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        determineCurrentLocation()
    }
    
    @IBAction func clearButton(_ sender: Any) {
        stringDate = nil
        coordinate = nil
        determineCurrentLocation()
    }
    
    func getApi(_ sURL: String) {
        ApiManager.fetchWeather(sURL, { data in
            self.weather = data
            DispatchQueue.main.async {
                self.reload()
                print("run")
            }
        })
        
        ApiManager.fetchForecast(sURL, {data in
            self.forecast = data
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        })
    }
    
    func reload(){
        date.text = ApiManager.getDate(unix: weather.time)
        summary.text = weather.summary
        picture.image = UIImage(named: weather.icon)
        precipProbability.text = "POP: \(weather.precipProbability)%"
        windSpeed.text = "Wind Speed: \(weather.windSpeed) mph"
        temperature.text = "Temperature: \(weather.temperature!)°F"
        apparentTemperature.text = "Feels like: \(weather.apparentTemperature!)°F"
        self.getSpeech()
    }

}

