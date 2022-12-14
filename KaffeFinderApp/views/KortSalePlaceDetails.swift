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

    @State var showSalePlace: Bool = false
    @State var pitcure:String?
 
    @State var list:[Groocery] = [Groocery]()
    var body: some View {
        HStack {
            Button(action: viewSalePlace) {
                Label("show", systemImage: "house")
            }.sheet(isPresented: $showSalePlace) {
                HStack(alignment: .top) {
                    Button(action: closeSheet) {
                        Image(systemName: "xmark")
                    }
                }
                VStack {
                  
                    Text(type ?? "")
                    Text(name ?? "")
                    Image(uiImage: getImage(groovery: pitcure ?? BaseImage().getBaseImage()))
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                  
                    Button(action: show) {
                        Label("show", systemImage: "house.fill")
                    }
                    VStack {
                        if showGrooceries {
                            List(list, id: \.id){
                                GrooceriesDetailsView(groocery: $0, admin: false)
                            }
                            
                            Button(action: closeGrooceries) {
                                Label("close", systemImage: "window")
                            }
                        }
                    }
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
    
    func closeSheet() {
        showSalePlace = false
    }
    
    func getImage(groovery: String) -> UIImage {
        
        guard let imageData =  Data(base64Encoded: groovery ) else {
            return UIImage(named: "")!
        }
        return UIImage(data:imageData)!
    }
    
    func closeGrooceries() {
        showGrooceries = false
    }
    
    
    func viewSalePlace() {
        showSalePlace = true

    }
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
