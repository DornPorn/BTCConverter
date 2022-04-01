//
//  BTCConverterApp.swift
//  BTCConverter
//
//  Created by Stanislav Rassolenko on 4/1/22.
//

import SwiftUI

@main
struct BTCConverterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
