//
//  SalePlaceView.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 09/09/2022.
//

import SwiftUI

struct SalePlaceView: View {
    @State var type:String = ""
    @State var name:String = ""
    @State var suscess:Bool = false
    @State var faliure:Bool = false
    @State var latitude: Double = 0
    @State var longtitude: Double = 0
    @ObservedObject var location: LocationManager = LocationManager()
    
    
   
    @State var netWork: NetWorkService = NetWorkService()
    func setCurrentLocation() {
        location.$location.sink {
            location in
            self.latitude = location?.coordinate.latitude ?? 0
            self.longtitude = location?.coordinate.longitude ?? 0
            
            
        }
    }
    var body: some View {
        
        Form {
            VStack {
                TextField("Type", text: $type)
                TextField("Name", text: $name)
            }
            HStack {
                Button(action: createSalePlace) {
                    Text("Add salePlace")
                }.alert("SalePlace added", isPresented: $suscess) {
                    Text("")
                }.alert("Fejl", isPresented: $faliure) {
                    Text("")
                }
                
            }
        }.onAppear {
            setCurrentLocation()
        }
    }
}
    
    struct SalePlaceView_Previews: PreviewProvider {
        static var previews: some View {
            SalePlaceView(location: LocationManager())
        }
    }
    
    extension SalePlaceView {
        
        
        func createSalePlace() {
            var salePlce: SalePlace = SalePlace()
            salePlce.lat = self.latitude
            salePlce.lng = self.longtitude
            salePlce.name = name
            salePlce.type = type
            salePlce.isClosed = false
            netWork.addSalePlaceToUser(salePlace: salePlce, id:String( LocalStorageService().getUserId())) {
                (res) in
                switch res {
                case .failure(let error):
                    faliure = true
                case .success(let success):
                    suscess = true
                }
                
            }
        }
        
    }

