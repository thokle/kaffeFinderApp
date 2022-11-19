//
//  Groocery.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 03/09/2022.
//

import Foundation


struct Groocery :Codable {
    
    var name:String?
    var type:String?
    var price:Double
    var picture:String?
    var  isSoldOut:Bool?
}
