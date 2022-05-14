//
//  SlediPariApp.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/14/22.
//

import SwiftUI

@main
struct SlediPariApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
