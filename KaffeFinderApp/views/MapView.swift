//
//  MapView.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 04/09/2022.
//

import SwiftUI
import CoreLocationUI
import MapKit


struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
    
}
struct MapView: View {

    @ObservedObject var location: LocationManager = LocationManager()
    var body: some View {
       Text("Hello")
    }
        
    }


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

extension MapView {

    func updateMap() {
        
       print("Update timer")
    }
}


