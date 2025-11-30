//
//  SettingsView.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import SwiftUI

struct SettingsView: View {

    // 4 settings stored with AppStorage
    @AppStorage("darkCryptoMode") private var darkCryptoMode = false
    @AppStorage("baseCurrency") private var baseCurrency = "USD"
    @AppStorage("refreshInterval") private var refreshInterval = 10.0
    @AppStorage("priceAlerts") private var priceAlerts = true

    let currencies = ["USD", "EUR", "GBP", "JPY"]

    var body: some View {
        Form {

            // Appearance
            Section(header: Text("Appearance")) {
                Toggle("Dark Crypto Mode", isOn: $darkCryptoMode)
            }

            // Currency Pref
            Section(header: Text("Currency")) {
                Picker("Base Currency", selection: $baseCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency)
                    }
                }
            }

            // Refresh Interval
            Section(header: Text("Refresh Settings")) {
                Stepper(value: $refreshInterval, in: 5...60, step: 5) {
                    Text("Refresh every \(Int(refreshInterval)) seconds")
                }
            }

            // Price Alerts
            Section(header: Text("Alerts")) {
                Toggle("Show Price Alerts", isOn: $priceAlerts)
            }

            // Step 11: Notifications
            Section(header: Text("Notifications")) {
                Button("Send Test Notification") {
                    NotificationManager.shared.requestPermission()
                    NotificationManager.shared.scheduleTestNotification()
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
