//
//  SettingsView.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import SwiftUI

struct SettingsView: View {
    
    // Persistent settings using AppStorage
    @AppStorage("darkMode") private var darkMode = false
    @AppStorage("baseCurrency") private var baseCurrency = "USD"
    @AppStorage("refreshInterval") private var refreshInterval = 10.0
    @AppStorage("priceAlerts") private var priceAlerts = true
    
    @State private var showNotificationAlert = false
    
    private let currencies = ["USD", "EUR", "GBP", "JPY", "CAD", "AUD"]
    
    var body: some View {
        Form {
            
            // Appearance section
            Section {
                Toggle(isOn: $darkMode) {
                    HStack {
                        Image(systemName: "moon.fill")
                            .foregroundColor(.indigo)
                            .frame(width: 30)
                        Text("Dark Mode")
                    }
                }
            } header: {
                Text("Appearance")
            } footer: {
                Text("Enable dark mode for better viewing in low light")
            }
            
            // Currency preferences section
            Section {
                Picker("Base Currency", selection: $baseCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        HStack {
                            Text(currencyFlag(for: currency))
                            Text(currency)
                        }
                        .tag(currency)
                    }
                }
                .pickerStyle(.menu)
            } header: {
                Text("Currency")
            } footer: {
                Text("Selected currency: \(baseCurrency)")
            }
            
            // Data refresh section
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        Text("Refresh Interval")
                        Spacer()
                        Text("\(Int(refreshInterval))s")
                            .foregroundColor(.secondary)
                    }
                    
                    Slider(value: $refreshInterval, in: 5...60, step: 5)
                        .tint(.accentColor)
                }
            } header: {
                Text("Data Refresh")
            } footer: {
                Text("How often crypto data is refreshed")
            }
            
            // Notifications section
            Section {
                Toggle(isOn: $priceAlerts) {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.orange)
                            .frame(width: 30)
                        Text("Price Alerts")
                    }
                }
                
                Button(action: sendTestNotification) {
                    HStack {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.green)
                            .frame(width: 30)
                        Text("Send Test Notification")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption.bold())
                            .foregroundColor(.secondary)
                    }
                }
            } header: {
                Text("Notifications")
            } footer: {
                Text("Receive alerts about significant price changes")
            }
            
            // About section
            Section {
                HStack {
                    Text("App Version")
                    Spacer()
                    Text(appVersion)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Build Number")
                    Spacer()
                    Text(buildNumber)
                        .foregroundColor(.secondary)
                }
            } header: {
                Text("About")
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Notification Sent", isPresented: $showNotificationAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("A test notification will appear in 5 seconds")
        }
    }
    
    // Send test notification
    private func sendTestNotification() {
        NotificationManager.shared.requestPermission()
        NotificationManager.shared.scheduleTestNotification()
        showNotificationAlert = true
    }
    
    // Get app version from Bundle
    private var appVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
    }
    
    // Get build number from Bundle
    private var buildNumber: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"
    }
    
    // Get flag emoji for currency
    private func currencyFlag(for currency: String) -> String {
        switch currency {
        case "USD": return "🇺🇸"
        case "EUR": return "🇪🇺"
        case "GBP": return "🇬🇧"
        case "JPY": return "🇯🇵"
        case "CAD": return "🇨🇦"
        case "AUD": return "🇦🇺"
        default: return "💱"
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
