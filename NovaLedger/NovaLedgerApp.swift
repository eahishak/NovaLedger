//
//  NovaLedgerApp.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import SwiftUI

@main
struct NovaLedgerApp: App {
    
    init() {
        // Request notification permissions on app launch
        NotificationManager.shared.requestPermission()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(getUserColorScheme())
        }
    }
    
    // Get user's preferred color scheme from settings
    private func getUserColorScheme() -> ColorScheme? {
        let darkMode = UserDefaults.standard.bool(forKey: "darkMode")
        return darkMode ? .dark : .light
    }
}
