//
//  NywordleApp.swift
//  Nywordle
//
//  Created by Mohamed Alwakil on 2025-02-27.
//

import SwiftUI

@main
struct NywordleApp: App {

    let appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appState)
                .preferredColorScheme(.dark)
        }
    }
}
