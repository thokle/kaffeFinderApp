//
//  GrooceryView.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 10/09/2022.
//

import SwiftUI

struct GrooceryView: View {
    @State var name:String = ""
    @State var type:String = ""
    @State var price:String = ""
    @State var picureUrl:String?
    @EnvironmentObject var vm: ViewModel
    @State var network:NetWorkService = NetWorkService()
    @State var salePlaceID:String
    @State var grooceyIsAddded = false
    var body: some View {
        
      
        VStack(alignment: .trailing) {
   
            TextField("Name", text: $name).backgroundStyle(.gray)
            TextField("Type", text: $type).backgroundStyle(.gray)
            TextField("Price", text: $price).backgroundStyle(.gray)
        }
        HStack {
            Button {
                vm.source = .camera
                vm.showPhotoPicker()
            } label: {
                Image(systemName: "camera")
            }.buttonStyle(.bordered)
            Button {
                vm.source = .library
                vm.showPhotoPicker()
            } label: {
               Image(systemName: "photo")
            }.buttonStyle(.bordered)
            Button {
                addGrooveToSalePlace()
            } label: {
                Text("Add groocery")
            }.alert("Groocery is added", isPresented: $grooceyIsAddded) {
                
            }.foregroundColor(.red)
            
            
            if let image = vm.image {
                ZoomableScrollView {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.6)
                    .frame(minWidth: 4, maxWidth: .infinity)
                    .padding(.horizontal)
            }
            
        }.sheet(isPresented: $vm.showPicker) {
            ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
            
        }
        
    }

        
    
    
    
    struct GrooceryView_Previews: PreviewProvider {
        static var previews: some View {
            GrooceryView( salePlaceID: "").environmentObject(ViewModel())
        }
    }
}

extension GrooceryView {
    func convertToBase64() -> String {

        return vm.image?.jpegData(compressionQuality: 0.0)?.base64EncodedString() ?? BaseImage().getBaseImage()

        
    }
    
    
    func addGrooveToSalePlace() {
        var salePlaceGroovery: SalePlaceGroocery = SalePlaceGroocery()
        var salePlace = SalePlace()
        salePlace.id = Int(salePlaceID)
        salePlaceGroovery.salePlace = salePlace
        salePlaceGroovery.salePlace?.id = Int(salePlaceID)
        var groocery = Groocery()
        groocery.price = Double(price)
        groocery.type = type
        groocery.name = name
        groocery.picture = convertToBase64()
        groocery.isSoldOut = false
        salePlaceGroovery.groocery = groocery
        self.network.addGroocery(groocery: salePlaceGroovery) {
            res in
            switch res {
            case .failure(let faluire):
                print(faluire.localizedDescription)
            case.success(let success):
                self.grooceyIsAddded = true
            }
        }
    }
}
