//
//  KaffeFinderAppApp.swift
//  KaffeFinderApp
//
//  Created by Thomas Kleist on 19/10/2022.
//

import SwiftUI

@main
struct KaffeFinderAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
