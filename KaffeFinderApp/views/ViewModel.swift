//
//  ViewModel.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 25/09/2022.
//

import Foundation



import UIKit
class ViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: CameraPicker.Source = .library
    
    func showPhotoPicker() {
        if source == .camera {
            if !CameraPicker.checkPermissions() {
                print("There is no camera on this device")
                return
            }
        }
        showPicker = true
    }
}
