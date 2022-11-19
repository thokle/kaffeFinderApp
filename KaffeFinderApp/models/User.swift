//
//  User.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 04/09/2022.
//

import Foundation


struct User: Codable {
    var id:Int?
    
    var  firstname:String?

    var   lastname:String?

    var   email:String?

    var   username:String?

    var   password:String?


    var address: [Addresse]?

    
}
