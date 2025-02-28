//
//  ContentView.swift
//  Nywordle
//
//  Created by Mohamed Alwakil on 2025-02-27.
//

import SwiftUI

struct ContentView: View {

    @Environment(AppState.self) var appState
    @AppStorage("theme") private var themeKey: String = Palette.green.key

    var body: some View {
        MainView()
            .onAppear {
                appState.theme = Palette.from(themeKey)
            }
            .onChange(of: appState.theme) {
                themeKey = appState.theme.key
            }
    }

}

#Preview {
    ContentView()
        .environment(AppState())
}
