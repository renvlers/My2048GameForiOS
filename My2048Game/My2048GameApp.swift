//
//  My2048GameApp.swift
//  My2048Game
//
//  Created by Renvle RS on 1/24/24.
//

import SwiftUI
import SwiftData

@main
struct My2048GameApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            IndexView()
        }
        .modelContainer(sharedModelContainer)
    }
}
