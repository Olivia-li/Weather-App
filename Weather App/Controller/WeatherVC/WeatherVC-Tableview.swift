//
//  WeatherVC-Tableview.swift
//  Weather App
//
//  Created by Olivia Li on 2020-03-09.
//  Copyright © 2020 Olivia Li. All rights reserved.
//

import Foundation
import UIKit

extension WeatherVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! weatherCell
        
        let weatherForecast = forecast[indexPath.row]
        
        
        cell.day.text = "\(ApiManager.getDayOfWeek(ApiManager.getDate(unix: weatherForecast.time)))"
        cell.picture.image = UIImage(named: weatherForecast.icon)
        cell.high.text = "\(weatherForecast.temperatureHigh!)"
        cell.low.text = "\(weatherForecast.temperatureLow!)"
        return cell
    }
    
    
}
