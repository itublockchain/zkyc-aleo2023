//
//  mobileApp.swift
//  mobile
//
//  Created by Muhittin Koybasi on 17.11.2023.
//

import SwiftUI
import SwiftData

@main
struct mobileApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            KYCRecord.self,
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
            ContentView()
                .environment(AleoManager())
                .environment(LocalAuthenticator())
        }
        .modelContainer(sharedModelContainer)
    }
}
