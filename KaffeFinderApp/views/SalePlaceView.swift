//
//  SalePlaceView.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 09/09/2022.
//

import SwiftUI

struct SalePlaceView: View {
    @State var type:String = ""
    @State var name:String = ""
    @State var suscess:Bool = false
    @State var faliure:Bool = false
    @State var latitude: Double = 0
    @State var longtitude: Double = 0
    @ObservedObject var location: LocationManager = LocationManager()
    @EnvironmentObject var vm: ViewModel
    
   
    @State var netWork: NetWorkService = NetWorkService()
    func setCurrentLocation() {
        location.$location.sink {
            location in
            self.latitude = location?.coordinate.latitude ?? 0
            self.longtitude = location?.coordinate.longitude ?? 0
            
            
        }
    }
    var body: some View {
        
        Form {
            VStack {
                TextField("Type", text: $type)
                TextField("Name", text: $name)
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
            }
            HStack {
                Button {
                    vm.source = .camera
                    vm.showPhotoPicker()
                } label: {
                    Text("Camera").font(.caption)
                }.buttonStyle(.bordered)
                Button {
                    vm.source = .library
                    vm.showPhotoPicker()
                } label: {
                    Text("Photoalbum").font(.caption)
                }.buttonStyle(.bordered)
                Button(action: createSalePlace) {
                    Text("Add salePlace").font(.caption)
                }.alert("SalePlace added", isPresented: $suscess) {
                    Text("SalePlace Is Added")
                }.alert("Fejl", isPresented: $faliure) {
                    Text("There was an Error")
                }.buttonStyle(.bordered)
              
            }.sheet(isPresented: $vm.showPicker) {
                ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                
            }
        }.onAppear {
            setCurrentLocation()
        }
    }
}
    
    struct SalePlaceView_Previews: PreviewProvider {
        static var previews: some View {
            SalePlaceView(location: LocationManager()).environmentObject(ViewModel())
        }
    }
    
    extension SalePlaceView {
        
        func convertToBase64() -> String {

            return vm.image?.jpegData(compressionQuality: 0.0)?.base64EncodedString() ?? BaseImage().getBaseImage()

            
        }
        func createSalePlace() {
            var salePlce: SalePlace = SalePlace()
            salePlce.lat = self.latitude
            salePlce.lng = self.longtitude
            salePlce.name = name
            salePlce.type = type
            salePlce.isClosed = false
            salePlce.picture = convertToBase64()
            netWork.addSalePlaceToUser(salePlace: salePlce, id:String( LocalStorageService().getUserId())) {
                (res) in
                switch res {
                case .failure(let error):
                    faliure = true
                case .success(let success):
                    suscess = true
                }
                
            }
        }
        
    }

