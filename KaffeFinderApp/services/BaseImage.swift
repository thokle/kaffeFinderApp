//
//  BaseImage.swift
//  KaffeFinderApp
//
//  Created by Thomas Kleist on 25/12/2022.
//

import Foundation
import SwiftUI

struct BaseImage{
  
    func getBaseImage()-> String {
        
        var pic =    UIImage(systemName: "photo.fill" )
      return  pic?.jpegData(compressionQuality: 0.0)?.base64EncodedString() ?? ""
    
    }
}
