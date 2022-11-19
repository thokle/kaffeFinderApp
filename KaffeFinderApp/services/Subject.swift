//
//  Subject.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 21/09/2022.
//

import Foundation


public class Subject {
    private lazy var observers = [IObserver]()
    
     func attach(_ observer: IObserver) {
        self.observers.append(observer)
    }
    
     func detach(_ observer: IObserver) {
        if let idx = observers.firstIndex(where: { $0 === observer }) {
                   observers.remove(at: idx)
                   print("Subject: Detached an observer.\n")
               }
    }
    
    public func noftify() {
        observers.forEach({$0.update(subject: self)})
    }
    
    
}
