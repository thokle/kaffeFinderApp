//
//  LocationManager.swift
//  KaffeFinderApp
//
//  Created by Thomas Kleist on 10/12/2022.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var locationStatus: CLAuthorizationStatus?
    public override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
      
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    
}

extension LocationManager: CLLocationManagerDelegate {
    var statusString: String {
          guard let status = locationStatus else {
              return "unknown"
          }
          
          switch status {
          case .notDetermined: return "notDetermined"
          case .authorizedWhenInUse: return "authorizedWhenInUse"
          case .authorizedAlways: return "authorizedAlways"
          case .restricted: return "restricted"
          case .denied: return "denied"
          default: return "unknown"
          }
      }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        
        DispatchQueue.main.async {
            self.location = location
        }
      
       
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           
        DispatchQueue.main.async {
            self.locationStatus = status
        }
        print(#function, statusString)
       }
}
