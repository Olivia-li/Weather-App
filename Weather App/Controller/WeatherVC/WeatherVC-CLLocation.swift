//
//  WeatherVC-CLLocation.swift
//  Weather App
//
//  Created by Olivia Li on 2020-03-08.
//  Copyright © 2020 Olivia Li. All rights reserved.
//

import Foundation
import CoreLocation

extension WeatherVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0] as CLLocation
        
    
        manager.stopUpdatingLocation()
        
        let longitude = "\(userLocation.coordinate.longitude)"
        let latitude = "\(userLocation.coordinate.latitude)"
        
        self.url = ApiManager.getURL(latitude: latitude, longitude: longitude)
        getApi(self.url!)
        
        getPlace(for: userLocation) { placemark in
            guard let placemark = placemark else { return }
            
            var output = ""
            if let town = placemark.locality {
                output = output + "\(town)"
            }
            if let state = placemark.administrativeArea {
                          output = output + ", \(state)"
                      }
            self.location.text = output
        }
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
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
    
    

}
    
