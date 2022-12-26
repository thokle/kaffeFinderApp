//
//  SalePlace.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 03/09/2022.
//

import Foundation

struct SalePlace: Codable {
    
    var id:Int?
    var  type:String?
    var   name:String?;
    var   isClosed:Bool?;
    var     lat:Double?;
    var     lng:Double?;
    var picture:String?
    var position:[Position]?
    var groocerySet:[Groocery]?
   
}



