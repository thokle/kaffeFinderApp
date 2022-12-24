//
//  GrooceriesDetailsView.swift
//  KaffeFinderApp
//
//  Created by Thomas Kleist on 21/12/2022.
//

import SwiftUI

struct GrooceriesDetailsView: View {
    @State var groocery:Groocery
    @State var admin:Bool = false
    var body: some View {
        VStack{
            if (!groocery.isSoldOut!) {
                if (groocery.picture?.count ?? 0 > 10) {
                    Image(uiImage: getImage(groovery: groocery))
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity).overlay(ImageOverLay())
                }
                
                HStack {
                    Text(groocery.name ?? "No Name")
                    Text(groocery.type ?? "No Type")
                    Text(groocery.price ?? 0 , format: .number)
                    if (admin) {
                        Button(action: setSoldOut) {
                            Text("Set SoldOut")
                        }
                    }
                    
                }
            }
        }
    }
}

struct GrooceriesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GrooceriesDetailsView(groocery: Groocery())
    }
}

extension GrooceriesDetailsView {
    
    func getImage(groovery: Groocery) -> UIImage {
        
        guard let imageData =  Data(base64Encoded: groovery.picture!) else {
            return UIImage(named: "")!
        }
        
        return UIImage(data:imageData)!
        
        
    }
    
    func setSoldOut(){
        
    }
}

struct ImageOverLay: View {
    var body: some View {
        ZStack {
                   Text("Test")
                       .font(.callout)
                       .padding(6)
                       .foregroundColor(.white)
               }.background(Color.black)
               .opacity(0.8)
               .cornerRadius(10.0)
               .padding(6)
           }
    }
