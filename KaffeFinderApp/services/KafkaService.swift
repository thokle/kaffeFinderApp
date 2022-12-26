//
//  KafkaService.swift
//  KaffeFinderApp
//
//  Created by Thomas Kleist on 30/11/2022.
//

import Foundation
import UIKit
import SwiftUI
import MapKit

class KafkaService: NSObject {

    
     
    var ip = "http://ad-scoop.com"
    var port = "8889"
 
  
    public override init() {
        super.init()
      
       
    }
    
    func reciveMessages(completion: @escaping (Result<[SalePlace],Error>)->Void) {
        

            print("calling open sale places")
            guard let url = URL(string: "\(self.ip):\(self.port)/sale/allopen") else {
                print("invalid url "); return
            }
            
            var request = URLRequest(url: url )
            
            URLSession.shared.dataTask(with: request) {
                (data, respose, error) in
                if let error = error {
                   
                }
                do {
                    if let urlresponse = respose as? HTTPURLResponse {
                        
                    }
                    var res = try JSONDecoder().decode([SalePlace].self, from: data!)
                    DispatchQueue.main.async {
                        completion(.success(res))
                                           
                    }
                    
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
                
            }.resume()
            
       
    }
    
     func convertAndSend(salePlaces: [SalePlace])-> [SaleCoordinates]? {
     
         var saleCoordinates:[SaleCoordinates] = []
        
        salePlaces.forEach { res in
        
            saleCoordinates.append( SaleCoordinates(coordinate: CLLocationCoordinate2D(latitude: res.lat ?? 0, longitude: res.lng ?? 0), saleId: res.id, name: res.name, type: res.type, picture: res.picture))
          
           
        }
        return saleCoordinates
    }
}
