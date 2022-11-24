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
    @StateObject var Login: LoginObservable = LoginObservable()
    @StateObject var vm = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Login).environmentObject(vm)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
