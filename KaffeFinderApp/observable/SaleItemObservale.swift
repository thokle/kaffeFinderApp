//
//  SaleItemObservale.swift
//  KaffeFinderApp
//
//  Created by Thomas Kleist on 14/12/2022.
//

import Foundation

protocol SaleItemObservable {
    var id: UUID {get}
    func update(list:SaleCoordinates)
}
