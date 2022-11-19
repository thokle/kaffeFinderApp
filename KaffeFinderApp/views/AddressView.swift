//
//  AddressView.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 06/09/2022.
//

import SwiftUI

struct AddressView: View {
    var timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true,  block: { (timer) in
        print("timer is calle")
    })
    var service:NetWorkService = NetWorkService()
  @State  var  streetname:String = ""
  @State  var  streetnumber:Int = 0
   @State var  city:String = ""
    @State var  postalCode:Int = 0
   @State var  country:String = ""
   
    @State var addressCreated: Bool = false
    var body: some View {
        NavigationView{
            Form {
                TextField("Street name", text: $streetname ).padding()
                TextField("Street number", value: $streetnumber, format: .number).padding()
                TextField("Zip code", value: $postalCode, format: .number).padding()
                TextField("City", text: $city).padding()
                TextField("Country", text: $country).padding()
                
                Button(action: addAddress){
                    Text("Add Addess").clipShape(Capsule())
                }.alert("Adress added", isPresented: $addressCreated) {
                    Text("Address is added")
                }
            }
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
    }
}

extension AddressView {
    func addAddress(){
        var addresse: UserAddress = UserAddress()
        addresse.user = User()
        addresse.address = Addresse()
        addresse.user?.id = LocalStorageService().getUserId()
        addresse.user?.email = LocalStorageService().getEmail()
        addresse.user?.username = LocalStorageService().getUserName()
        addresse.address?.city = city
        addresse.address?.streetname = streetname
        addresse.address?.country = country
        addresse.address?.postalCode = postalCode
        self.service.addAddress(userAddresse: addresse) {
            (completion) in
            switch completion {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let sucess):
             addressCreated = true
            }
            
        }
    }
}
