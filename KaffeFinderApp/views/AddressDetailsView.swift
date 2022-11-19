//
//  AddressDetailsView.swift
//  KaffeFinderApp
//
//  Created by Thomas Kleist on 13/11/2022.
//

import SwiftUI

struct AddressDetailsView: View {
    
    enum ActiveSheet : String, Identifiable { // <--- note that it's now Identifiable
           case sheetA, sheetB
           var id: String {
               return self.rawValue
           }
       }
       
       @State var activeSheet : ActiveSheet? = nil

    @State var address:Addresse
    var body: some View {
     
            VStack{
                Text(address.streetname ?? "Street name")
                Text(address.streetnumber  ?? 0, format: .number)
                Text(address.postalCode ?? 0, format: .number)
                Text(address.country ?? "0")
                HStack {
                    Button(action: {
                        self.activeSheet = .sheetA
                    }) {
                        Text("Place View")
                    }
                    
                    
                    Button(action: {
                        self.activeSheet = .sheetB
                    }) {
                        Text("Add Place")
                    }
                }.sheet(item: $activeSheet) { sheet in // <--- sheet is of type ActiveSheet and lets you present the appropriate sheet based on which is active
                    switch sheet {
                    case .sheetA:
                    PlaceListView()
                    case .sheetB:
                       SalePlaceView()
                    }
                }
        }
    }
}

struct AddressDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AddressDetailsView(address: Addresse())
    }
}

extension AddressDetailsView {
   
}
