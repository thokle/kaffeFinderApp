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
    var body: some View {
        HStack {
            Text(salePlace.type ??  "NO TYPE")
            Text(salePlace.name ?? "No Name")
           
        }
        VStack{
            HStack {
                Button(action: openGrooceryList) {
                    Text("Show Grooceries")
                }.sheet(isPresented: $showGroocery) {
                    GrooceryListView()
                }.buttonStyle(.bordered)
                Button(action: addGroocery) {
                    Text("Add Groocery")
                }.sheet(isPresented: $addDetails) {
                    AddGrooceryView()
                }.buttonStyle(.bordered)
                
            }
            Toggle("OpenScop", isOn: $openShop)
                .toggleStyle(.switch)
            Toggle("Close Shop", isOn: $closeShop).toggleStyle(.switch)
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
   
}
