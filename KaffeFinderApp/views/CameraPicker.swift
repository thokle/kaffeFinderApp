//
//  CameraPicker.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 25/09/2022.
//

import Foundation

import UIKit

enum CameraPicker {
    enum Source: String {
        case library, camera
    }
    
    static func checkPermissions() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            return true
        } else {
            return false
        }
    }
}
