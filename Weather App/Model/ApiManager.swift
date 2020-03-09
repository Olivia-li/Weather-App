//
//  ApiManager.swift
//  Weather App
//
//  Created by Olivia Li on 2020-03-08.
//  Copyright © 2020 Olivia Li. All rights reserved.
//

import Foundation

class ApiManager{
    static let sURL = "https://api.darksky.net/forecast/dc76cd7e80bc4de10df91ea21901d700/37.785834,-122.406417"
    
    static func getURL(latitude: Double, longitude: Double, date: Int) -> String{
        return "\(sURL)\(latitude),\(longitude),\(date)"
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
                
                // Decode JSON and serialization
                let request = try! JSONDecoder().decode(ForecastRequest.self, from: data)
                completionHandler(request.currently)
                
            }
            task.resume()
        }
}
