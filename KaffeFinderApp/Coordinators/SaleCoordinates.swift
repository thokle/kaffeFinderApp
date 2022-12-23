//
//  SaleCoordinates.swift
//  KaffeFinderApp
//
//  Created by Thomas Kleist on 11/12/2022.
//

import Foundation

import MapKit
struct SaleCoordinates: Identifiable {
    
    var id =  UUID()
    var coordinate: CLLocationCoordinate2D?
    var saleId: Int?
    
}
