//
//  ClickDetailView.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 02/10/2022.
//

import SwiftUI

struct ClickDetailView: View {
    @State var shopname: String? = ""
    @State var type: String? = ""
    var body: some View {
        Circle()
            .frame(width: 2, height: 2).toolbar(content: {
                Text(shopname!)
                Text(type!)
            })
    }
}

struct ClickDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClickDetailView()
    }
}
