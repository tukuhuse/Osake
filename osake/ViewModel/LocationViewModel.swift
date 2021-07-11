//
//  LocationViewModel.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/11.
//

import Foundation
import CoreLocation

class LocationViewModel: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var lastknownlocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastknownlocation = locations.first?.coordinate
    }
}
