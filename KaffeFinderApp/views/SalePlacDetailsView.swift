//
//  SalePlacDetailsView.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 10/09/2022.
//

import SwiftUI

struct SalePlacDetailsView: View {
    @State var showGroocery: Bool = false
    @State var addDetails:Bool = false
    @State var salePlace:SalePlace
    @State var closeShop:Bool = false
    @State var openShop:Bool = false

    @State var shopIsOpen:Bool = false
    @State var shopIsClosed: Bool = false
    @State var netWork: NetWorkService = NetWorkService()
    @State var latitude: Double = 0
    @State var longitude: Double = 0
    @StateObject var location: LocationManager = LocationManager()
    
    var userLatitude: String {
        return "\(location.location?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(location.location?.coordinate.longitude ?? 0)"
    }
    
    var body: some View {
        
        Text("Hello")
        
        VStack{
            Spacer()
            
            HStack {
                Button(action: openGrooceryList) {
                    Text("Show Grooceries")
                }.sheet(isPresented: $showGroocery) {
                    GrooceryListView(saelPlaceId: salePlace.id ?? 0)
                }.buttonStyle(.bordered)
                Button(action: addGroocery) {
                    Text("Add Groocery")
                    
                }.sheet(isPresented: $addDetails) {
                    GrooceryView(salePlaceID:  String( salePlace.id ?? 0 ))
                    
                }.buttonStyle(.bordered)
                
            }
            VStack {
                Button("Open shop") {
                    open(id: salePlace.id ?? 0)
                }
                Button("Close shop") {
                    close(id: salePlace.id ?? 0)
                }
            }.font(.title)
        }
        
    }
        
    }
    
    
    struct SalePlacDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            SalePlacDetailsView(salePlace: SalePlace())
        }
    }
    


extension SalePlacDetailsView {
    func openGrooceryList() {
        self.showGroocery.toggle()
    }
    
    func addGroocery() {
        self.addDetails.toggle()
    }
    
    func close(id: Int) {
        self.netWork.closeShop(id: id) {
            res in
            switch res {
            case .success(let success):
                print(success)
                shopIsClosed = true
            case .failure(let error):
                print(error.localizedDescription as! Error)
            }
        }
    }
    
    func open(id: Int) {
        salePlace.lat = Double(userLatitude)
        salePlace.lng = Double(userLongitude)
        salePlace.isClosed = false
        self.netWork.openShop(id: id, salePlace: salePlace) {
            (res) in
            switch res {
            case .success(let success):
                print(success)
                shopIsOpen = true;
            case .failure(let error):
                print(error.localizedDescription as! Error)
            }
        }
        
    }
   
}
