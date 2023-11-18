//
//  ContentView.swift
//  mobile
//
//  Created by Muhittin Koybasi on 17.11.2023.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    var body: some View {
        TabView {
            AccountView()
                .tabItem { Label("Home", systemImage: "house.fill") }
            MyDataView()
                .tabItem { Label("My Data", systemImage: "rectangle.stack") }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [KYCRecord.self], inMemory: true)
        .environment(LocalAuthenticator())
        .environment(AleoManager())

}
