//
//  Forecast.swift
//  Weather App
//
//  Created by Olivia Li on 2020-03-08.
//  Copyright © 2020 Olivia Li. All rights reserved.
//

import Foundation

class ForecastRequest: Decodable{
    let currently: Forecast
    let daily: [Forecast]
    
    enum CodingKeys:String, CodingKey {
        case daily, currently
    }
    
    enum DataKeys: String, CodingKey {
        case data
    }

    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
                
        self.currently = try valueContainer.decode(Forecast.self, forKey: .currently)
        let dailyContainer = try valueContainer.nestedContainer(keyedBy: DataKeys.self, forKey: .daily)
        
        self.daily = try dailyContainer.decode([Forecast].self, forKey: .data)
    }
}

struct Forecast: Decodable{
    var time: Int
    var summary: String
    var icon: String
    var precipProbability: Double
    var precipType: String?
    var windSpeed: Double
    var temperature: Double?
    var apparentTemperature: Double?
    var temperatureHigh: Double?
    var temperatureLow: Double?
}
