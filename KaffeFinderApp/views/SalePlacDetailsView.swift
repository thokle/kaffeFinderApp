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
    @State var location: LocationManager = LocationManager()
    
    var userLatitude: String {
        return "\(location.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(location.lastLocation?.coordinate.longitude ?? 0)"
    }
    var body: some View {
        HStack {
            Text(salePlace.type ??  "NO TYPE")
            Text(salePlace.name ?? "No Name")
            
        }
        VStack{
            Spacer()
            
            HStack {
                Button(action: openGrooceryList) {
                    Text("Show Grooceries")
                }.sheet(isPresented: $showGroocery) {
                    GrooceryListView()
                }.buttonStyle(.bordered)
                Button(action: addGroocery) {
                    Text("Add Groocery")
                    GrooceryView(salePlaceID: "0")
                }.sheet(isPresented: $addDetails) {
                    }.buttonStyle(.bordered)
                
            }
            Toggle("OpenScop", isOn: $openShop).onChange(of: openShop) { value in
                print(value)
                if value {
                    open(id: salePlace.id ?? 0)
                } else {
                    close(id: salePlace.id ?? 0)
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
