//
//  ContentView.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var titleVisible = false
    @State private var rotateCoin = false
    @State private var bounce = false
    @State private var showAlert = false
    @State private var showActionSheet = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    
                    // Animated title with fade-in effect
                    Text(NSLocalizedString("app_title", comment: ""))
                        .font(.largeTitle.bold())
                        .foregroundColor(Color("PrimaryNavy"))
                        .opacity(titleVisible ? 1 : 0)
                        .animation(.easeIn(duration: 1.2), value: titleVisible)
                    
                    // Continuously rotating logo
                    Image("NovaLedgerImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160)
                        .rotationEffect(.degrees(rotateCoin ? 360 : 0))
                        .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: rotateCoin)
                    
                    // Bouncing start button with action sheet trigger
                    Button(NSLocalizedString("button_start", comment: "")) {
                        showActionSheet = true
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .offset(y: bounce ? -10 : 0)
                    .animation(.easeInOut(duration: 1).repeatForever(), value: bounce)
                    
                    Divider()
                        .padding(.vertical, 10)
                    
                    // Alert demonstration button
                    Button(NSLocalizedString("button_alert", comment: "")) {
                        showAlert = true
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    
                    // Action sheet demonstration button
                    Button(NSLocalizedString("button_options", comment: "")) {
                        showActionSheet = true
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    
                    // Navigation to app info
                    NavigationLink(destination: InfoView()) {
                        Text(NSLocalizedString("button_info", comment: ""))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("PrimaryNavy"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    // Navigation to settings
                    NavigationLink(destination: SettingsView()) {
                        Text(NSLocalizedString("button_settings", comment: ""))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("PrimaryNavy"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Divider()
                        .padding(.vertical, 10)
                    
                    // Crypto API views
                    NavigationLink(destination: CryptoView1()) {
                        Text(NSLocalizedString("button_crypto_status", comment: ""))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    NavigationLink(destination: CryptoView2()) {
                        Text(NSLocalizedString("button_market_overview", comment: ""))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 30)
            }
            .onAppear {
                titleVisible = true
                rotateCoin = true
                bounce = true
            }
            .alert(
                NSLocalizedString("alert_title", comment: ""),
                isPresented: $showAlert
            ) {
                Button(NSLocalizedString("alert_ok", comment: ""), role: .cancel) {}
            } message: {
                Text(NSLocalizedString("alert_message", comment: ""))
            }
            .confirmationDialog(
                NSLocalizedString("action_title", comment: ""),
                isPresented: $showActionSheet,
                titleVisibility: .visible
            ) {
                Button(NSLocalizedString("option_one", comment: "")) {
                    // Trigger data refresh
                }
                Button(NSLocalizedString("option_two", comment: "")) {
                    // Navigate to market info
                }
                Button(NSLocalizedString("option_three", comment: "")) {
                    // Show price history
                }
                Button(NSLocalizedString("cancel", comment: ""), role: .cancel) {}
            }
        }
    }
}

// Custom button styles for consistency
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryNavy"))
            .foregroundColor(.white)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

#Preview {
    ContentView()
}
