//
//  KortSalePlaceDetails.swift
//  KaffeFinderApp
//
//  Created by Thomas Kleist on 23/12/2022.
//

import SwiftUI

struct KortSalePlaceDetails: View {
    
    @State var type: String?
    @State var name: String?
    @State var salePlaceId: Int?
    @State var netWork:NetWorkService = NetWorkService()
    @State var showGrooceries: Bool = false
    @State var list:[Groocery] = [Groocery]()
    var body: some View {
        HStack {
           Text("SalePlace ID  \(salePlaceId ?? 0)")
            Button(action: show) {
                Label("show", systemImage: "house")
            }
           
        }.sheet(isPresented: $showGrooceries) {
            VStack {
                Text(type ?? "")
                Text(name ?? "")
                List(list, id: \.id){
                    GrooceriesDetailsView(groocery: $0, admin: false)
                }.onAppear(perform: getGrooceriesForSalePlace)
            }
        }
    }
}

struct KortSalePlaceDetails_Previews: PreviewProvider {
    static var previews: some View {
        KortSalePlaceDetails()
    }
}

extension KortSalePlaceDetails {
    
    func show() {
        showGrooceries = true
    }
    func getGrooceriesForSalePlace() {
        self.netWork.getGrooceryBySalePlace(salePlace: salePlaceId ?? 0) {
            res in
            
            switch res {
                
            case .success(let success):
                list  = success
                
            case .failure(let faliure):
                print(faliure.localizedDescription)
                
            
            
            }
        }
    }
}
