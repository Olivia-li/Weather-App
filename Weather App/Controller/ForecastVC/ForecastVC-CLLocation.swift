//
//  ForecastVC-CLLocation.swift
//  Weather App
//
//  Created by Olivia Li on 2020-03-09.
//  Copyright © 2020 Olivia Li. All rights reserved.
//

import Foundation
import CoreLocation

extension ForecastVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        
        let longitude = "\(userLocation.coordinate.longitude)"
        let latitude = "\(userLocation.coordinate.latitude)"
        
        self.url = ApiManager.getURL(latitude: latitude, longitude: longitude)
        getApi(self.url!)
    }
    
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }
    }
}
    
