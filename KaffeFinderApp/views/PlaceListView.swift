//
//  PlaceListView.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 14/10/2022.
//

import SwiftUI

struct PlaceListView: View {
    @State var netWork: NetWorkService = NetWorkService()
    @State var places:[SalePlace] = [SalePlace]()
    var body: some View {
       
        List(places, id: \.id) {
           SalePlacDetailsView(salePlace: $0)
        }.onAppear(perform:loadSalePlaces)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView()
    }
}

extension PlaceListView {
    func loadSalePlaces(){
        netWork.getSalePlacesByUserName(userName: LocalStorageService().getUserName()) {
            (res) in
            switch res {
            case .success(let success):
                 places = try! success
            case.failure(let falure):
                print(falure)
            }
        }
    }
    
}


