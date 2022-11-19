//
//  UserDetailsView.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 06/09/2022.
//

import SwiftUI

struct UserDetailsView: View {
    @State var  localstorage  = LocalStorageService()
    var body: some View {
        VStack{
            Text(localstorage.getUserName())
        }
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView()
    }
}
