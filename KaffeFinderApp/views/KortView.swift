//
//  KortView.swift
//  KaffeFinderApp
//
//  Created by Thomas Kleist on 11/12/2022.
//

import SwiftUI
import MapKit
struct KortView: View {
    
    @ObservedObject var locationManager: LocationManager = LocationManager()
    @State var kafkaService: KafkaService = KafkaService()
    @State var search: String = ""
    
    @State var region  = MKCoordinateRegion.defaultRegion
    
    @State var annotations: [SaleCoordinates]?

    private func setCurrentLocation() {
        locationManager.$location.sink {
            res in
            region.center.longitude =  res?.coordinate.longitude ?? 0
            region.center.latitude = res?.coordinate.latitude ?? 0
            region.span.latitudeDelta =  0.5
            region.span.longitudeDelta = 0.5
            print("view \(res?.coordinate.latitude) \(res?.coordinate.longitude)")
        }
    }
    
    private func setSalePlaceAnnotations() {
        kafkaService.reciveMessages { res in
            
            switch res {
            case .success(let success):
                self.annotations =  kafkaService.convertAndSend(salePlaces: success)
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        }
    
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if locationManager.location != nil {
                VStack(alignment: .center)  {
                   // TextField("Search", text: $search).textFieldStyle(.roundedBorder)(.white)
                }
                Map(coordinateRegion: $region, annotationItems: annotations ?? []) { res in
                    MapAnnotation(coordinate: res.coordinate!) {
                        Text("Hello").backgroundStyle(.yellow).foregroundColor(.white)
                    }
                }
                      
                    
           
                VStack(alignment: .center) {
                    Button("Get Open Shops") {
                        
                    }.buttonStyle(.bordered).frame(width: 160, height: 23, alignment: .center)
                    
                }
            }
                    
            else {
                
            }
        }.onAppear {
            
           
            setCurrentLocation()
            setSalePlaceAnnotations()
           
        }
    }
}

struct KortView_Previews: PreviewProvider {
    static var previews: some View {
        KortView()
    }
}


