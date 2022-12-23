//
//  ObserservedFactory.swift
//  KaffeFinderApp
//
//  Created by Thomas Kleist on 14/12/2022.
//

import Foundation

class ObservedFactory: NSObject {
    override init() {
        super.init()
    }
    
    var saleItemObservables =  [SaleItemObservable]()
    func receiveOpenSalePlace (salePlace: SaleCoordinates) {
        notifySalePlaces(salePlace: salePlace)
       }
    
    
    func notifySalePlaces(salePlace: SaleCoordinates){
        for item in saleItemObservables {
            item.update(list: salePlace)
        }
    }

    func registerSaleItemObservalbe(saleItem: SaleItemObservable) {
        self.saleItemObservables.append(saleItem)
    }

    func decouple(item: SaleItemObservable){
        
    }
    
}
