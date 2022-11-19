//
//  ClickDetail.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 02/10/2022.
//

import Foundation

import CoreLocation
struct ClickDetail: Identifiable {
    var coordinate: CLLocationCoordinate2D
    var shopname: String
    var type: String
    var id = UUID()
    
}
