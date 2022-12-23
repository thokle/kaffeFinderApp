//
//  GrooceryListView.swift
//  KaffeFinderApp
//
//  Created by Thomas Kleist on 28/10/2022.
//

import SwiftUI

struct GrooceryListView: View {
    @State var saelPlaceId:Int
    @State var network: NetWorkService  = NetWorkService()
    @State var grooceries:[Groocery] = [Groocery]()
    var body: some View {
        List(grooceries, id: \.id){
            GrooceriesDetailsView(groocery: $0)
        }.onAppear(perform: loadGroocerisForSalePlace)
    }
}

struct GrooceryListView_Previews: PreviewProvider {
    static var previews: some View {
        GrooceryListView(saelPlaceId: 0)
    }
}


extension GrooceryListView {
    
    func loadGroocerisForSalePlace(){
        self.network.getGrooceryBySalePlace(salePlace: saelPlaceId ?? 0) {
            res in
            
            switch res {
            case .success(let success):
                self.grooceries = success
                
            case .failure(let faliure):
                print(faliure.localizedDescription)
            }
            
        }
    }
}


