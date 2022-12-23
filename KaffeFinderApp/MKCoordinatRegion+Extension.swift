//
//  MKCoordinatRegion+Extension.swift
//  KaffeFinderApp
//
//  Created by Thomas Kleist on 11/12/2022.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static var defaultRegion: MKCoordinateRegion {
      MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1, longitude: 1), latitudinalMeters: 1, longitudinalMeters: 100)
    }
}
