//
//  GrooceryView.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 10/09/2022.
//

import SwiftUI

struct GrooceryView: View {
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        NavigationView {
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
            HStack {
               
                Button {
                    vm.source = .camera
                    vm.showPhotoPicker()
                } label: {
                    Text("Camera")
                }
                Button {
                    vm.source = .library
                    vm.showPhotoPicker()
                } label: {
                    Text("Photoalbum")
                }
            }
        }.sheet(isPresented: $vm.showPicker) {
            ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                .ignoresSafeArea()
        }
        .navigationTitle("Opret vare")
        
        
    }
}

struct GrooceryView_Previews: PreviewProvider {
    static var previews: some View {
        GrooceryView()
    }
}
