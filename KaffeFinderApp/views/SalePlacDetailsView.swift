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
        VStack(alignment: .leading){
       
            Text(salePlace.name ?? "No Name").border(.shadow(.inner(radius: -1)))
            Text(salePlace.type ?? "No Type")

            
            HStack {
                VStack(alignment: .center){
                    Button(action: openGrooceryList) {
                        Image( "list").resizable().frame(width: 20, height: 20)
                    }.sheet(isPresented: $showGroocery) {
                        GrooceryListView(saelPlaceId: salePlace.id ?? 0)
                    }.buttonStyle(.bordered)
                    Text("List Groocries").font(.system(size: 7))
                }
                
                VStack(alignment: .center) {
                    Button(action: addGroocery) {
                        Image("add").resizable().frame(width: 20, height: 20)
                        
                    }.sheet(isPresented: $addDetails) {
                        GrooceryView(salePlaceID:  String( salePlace.id ?? 0 ))
                        
                    }.buttonStyle(.bordered)
                    Text("Add Groocery").font(.system(size: 7))
                }
                VStack(alignment: .center) {
                    Button(action: open) {
                        Image("open-sign").resizable().frame(width: 20, height: 20)
                    }.buttonStyle(.bordered).alert("Shop Is Open", isPresented: $shopIsOpen) {
                        
                    }
                    Text("Open Shop").font(.system(size: 7))
                }
                VStack(alignment: .center) {
                    Button(action: close){
                        Image("shop-close-clipart.png").resizable().frame(width: 20, height: 20)
                    }.buttonStyle(.bordered).alert("Shop is closed", isPresented: $shopIsClosed) {
                        
                    }
                    Text("Close Shop").font(.system(size: 7))
                    
                }
            }
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
    
    func close() {
        self.netWork.closeShop(id: salePlace.id!) {
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
    
    func open() {
        salePlace.lat = Double(userLatitude)
        salePlace.lng = Double(userLongitude)
        salePlace.isClosed = false
        self.netWork.openShop(id: salePlace.id!, salePlace: salePlace) {
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
