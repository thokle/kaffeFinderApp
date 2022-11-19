//
//  Addresse.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 04/09/2022.
//

import Foundation


struct Addresse: Codable {
    var id:Int?
    var  streetname:String?
    var  streetnumber:Int?
    var  city:String?
    var  postalCode:Int?
    var  country:String?
    var  lattitude:Double?
    var  longitude:Double?
    var salePlaceSet:[SalePlace]?
    
    
    
}
