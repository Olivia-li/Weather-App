//
//  ApiManager.swift
//  Weather App
//
//  Created by Olivia Li on 2020-03-08.
//  Copyright © 2020 Olivia Li. All rights reserved.
//

import Foundation

class ApiManager{
    static let sURL = "https://api.darksky.net/forecast/dc76cd7e80bc4de10df91ea21901d700/"
    
    
    static func getURL(_ latitude: String,_  longitude: String, date: Int) -> String{
        return "\(sURL)\(latitude),\(longitude),\(date)"
    }
    
    static func getURL(latitude: String, longitude: String) -> String{
        return "\(sURL)\(latitude),\(longitude)"
    }
    
    static func getDate(unix: Double) -> NSDate{
        return NSDate(timeIntervalSince1970: unix)
    }
    
    
    static func removeTimeStamp(fromDate: Date) -> Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: fromDate)) else {
            fatalError("Failed to strip time from Date object")
        }
        return date
    }
    
    static func getDayOfWeek(_ today: NSDate?) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringDate = formatter.string(from: today! as Date)
        let dateNoTime = formatter.date(from: stringDate)
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: dateNoTime!)
        switch weekDay{
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        case 7:
            return "Sunday"
        default:
            return "Day not found"
        }
    }

    static func fetchWeather(_ fullURL: String, _ completionHandler: @escaping (Forecast) -> Void) {
        guard let url = URL(string: fullURL) else {
                return
            }
            
            var request = URLRequest(url: url, timeoutInterval: Double.infinity)
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(String(describing: error))
                    return
                }
                
                let request = try! JSONDecoder().decode(ForecastRequest.self, from: data)
                completionHandler(request.currently)
                
            }
            task.resume()
        }
    
    static func fetchForecast(_ fullURL: String, _ completionHandler: @escaping ([Forecast]) -> Void) {
    guard let url = URL(string: fullURL) else {
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            let request = try! JSONDecoder().decode(ForecastRequest.self, from: data)
            completionHandler(request.daily)
            
        }
        task.resume()
    }
}
