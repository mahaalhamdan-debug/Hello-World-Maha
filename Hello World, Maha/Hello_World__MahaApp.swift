//
//  Hello_World__MahaApp.swift
//  Hello World, Maha
//
//  Created by Maha Alhamdan on 29/05/1448 AH.
//

import SwiftUI
import SwiftData

@main
struct Hello_World__MahaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Journal.self)
    }
}
