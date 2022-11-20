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
    @ObservedObject var location: LocationManager = LocationManager()
    
    @State var netWork: NetWorkService = NetWorkService()
    
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
            salePlce.lat = location.lastLocation?.coordinate.latitude
            salePlce.lat = location.lastLocation?.coordinate.longitude
            salePlce.name = name
            salePlce.type = type
            salePlce.isClosed = true
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

