//
//  AddAddresse.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 04/09/2022.
//

import SwiftUI

struct AddAddresse: View {
    @State var netWork: NetWorkService = NetWorkService()
    @State var address:[Addresse] = [Addresse]()

    var body: some View {
        List(address, id: \.id) {
            AddressDetailsView(address: $0)
        }.onAppear(perform:loadAddresses)
    }
}

struct AddAddresse_Previews: PreviewProvider {
    static var previews: some View {
        AddAddresse()
    }
}

extension AddAddresse {
    func loadAddresses() {
        netWork.getAddresssFromEmail(email: LocalStorageService().getEmail()) {
            (res) in
            switch res {
            case .success(let success):
                 address = try! success!
            case.failure(let falure):
                print(falure)
            }
        }
    }
}
