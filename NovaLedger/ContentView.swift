//
//  ContentView.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import SwiftUI

struct ContentView: View {

    // Animations
    @State private var titleVisible = false
    @State private var rotateCoin = false
    @State private var bounce = false

    // Step 6 — Alert
    @State private var showAlert = false

    // Step 7 — Action Sheet
    @State private var showActionSheet = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {

                // ---- Animation 1: Fade-in title ----
                Text(NSLocalizedString("app_title", comment: ""))
                    .font(.largeTitle.bold())
                    .foregroundColor(Color("PrimaryNavy"))
                    .opacity(titleVisible ? 1 : 0)
                    .animation(.easeIn(duration: 1.2), value: titleVisible)

                // ---- Animation 2: Rotating logo ----
                Image("NovaLedgerImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160)
                    .rotationEffect(.degrees(rotateCoin ? 360 : 0))
                    .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: rotateCoin)

                // ---- Animation 3: Bouncing button ----
                Button(NSLocalizedString("button_start", comment: "")) {
                    showActionSheet = true
                }
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(12)
                .offset(y: bounce ? -10 : 0)
                .animation(.easeInOut(duration: 1).repeatForever(), value: bounce)


                // ---- Step 6: Alert button ----
                Button(NSLocalizedString("button_alert", comment: "")) {
                    showAlert = true
                }
                .padding()
                .background(Color("PrimaryNavy"))
                .foregroundColor(.white)
                .cornerRadius(12)

                // ---- Step 7: Action sheet button ----
                Button(NSLocalizedString("button_options", comment: "")) {
                    showActionSheet = true
                }
                .padding()
                .background(Color("PrimaryNavy"))
                .foregroundColor(.white)
                .cornerRadius(12)


                // ---- Step 8: InfoView navigation ----
                NavigationLink(destination: InfoView()) {
                    Text(NSLocalizedString("button_info", comment: ""))
                        .padding()
                        .background(Color("PrimaryNavy"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                // ---- Step 9: Settings navigation ----
                NavigationLink(destination: SettingsView()) {
                    Text(NSLocalizedString("button_settings", comment: ""))
                        .padding()
                        .background(Color("PrimaryNavy"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                // ---- Step 12: Crypto API View 1 ----
                NavigationLink(destination: CryptoView1()) {
                    Text(NSLocalizedString("button_crypto_status", comment: ""))
                        .padding()
                        .background(Color("PrimaryNavy"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                // ---- Step 12: Crypto API View 2 ----
                NavigationLink(destination: CryptoView2()) {
                    Text(NSLocalizedString("button_market_overview", comment: ""))
                        .padding()
                        .background(Color("PrimaryNavy"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
            .onAppear {
                titleVisible = true
                rotateCoin = true
                bounce = true
            }


            // -------- ALERT (Step 6) --------
            .alert(
                NSLocalizedString("alert_title", comment: ""),
                isPresented: $showAlert
            ) {
                Button(NSLocalizedString("alert_ok", comment: ""), role: .cancel) {}
            } message: {
                Text(NSLocalizedString("alert_message", comment: ""))
            }


            // -------- ACTION SHEET (Step 7) --------
            .confirmationDialog(
                NSLocalizedString("action_title", comment: ""),
                isPresented: $showActionSheet,
                titleVisibility: .visible
            ) {
                Button(NSLocalizedString("option_one", comment: "")) { }
                Button(NSLocalizedString("option_two", comment: "")) { }
                Button(NSLocalizedString("option_three", comment: "")) { }
                Button(NSLocalizedString("cancel", comment: ""), role: .cancel) { }
            }
        }
    }
}

#Preview {
    ContentView()
}
