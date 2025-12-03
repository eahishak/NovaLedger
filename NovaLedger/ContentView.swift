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
    @State private var selectedAction = ""
    @State private var showActionResult = false
    @State private var navigateToMarket = false
    @State private var isRefreshing = false
    @State private var showPriceHistory = false

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
                    
                    // Continuously rotating logo with refresh indicator
                    ZStack {
                        Image("NovaLedgerImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160)
                            .rotationEffect(.degrees(rotateCoin ? 360 : 0))
                            .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: rotateCoin)
                        
                        if isRefreshing {
                            ProgressView()
                                .scaleEffect(2)
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .background(
                                    Circle()
                                        .fill(Color.black.opacity(0.6))
                                        .frame(width: 80, height: 80)
                                )
                        }
                    }
                    
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
                        HStack {
                            Image(systemName: "bitcoinsign.circle.fill")
                                .font(.title2)
                            Text(NSLocalizedString("button_crypto_status", comment: ""))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    
                    NavigationLink(destination: CryptoView2(), isActive: $navigateToMarket) {
                        HStack {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.title2)
                            Text(NSLocalizedString("button_market_overview", comment: ""))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    
                    // Quick stats card
                    if !isRefreshing {
                        VStack(spacing: 12) {
                            HStack {
                                Image(systemName: "clock.fill")
                                    .foregroundColor(.accentColor)
                                Text("Last Updated")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(currentTime)
                                    .font(.caption.bold())
                            }
                            
                            HStack {
                                Image(systemName: "network")
                                    .foregroundColor(.green)
                                Text("Status")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("Online")
                                    .font(.caption.bold())
                                    .foregroundColor(.green)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 5)
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
                    handleRefreshData()
                }
                Button(NSLocalizedString("option_two", comment: "")) {
                    handleViewMarket()
                }
                Button(NSLocalizedString("option_three", comment: "")) {
                    handlePriceHistory()
                }
                Button(NSLocalizedString("cancel", comment: ""), role: .cancel) {}
            }
            .alert("Action Completed", isPresented: $showActionResult) {
                Button("OK", role: .cancel) {
                    if showPriceHistory {
                        showPriceHistoryAlert()
                    }
                }
            } message: {
                Text(selectedAction)
            }
            .sheet(isPresented: $showPriceHistory) {
                PriceHistorySheet()
            }
        }
    }
    
    // Current time formatted
    private var currentTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
    
    // Handle refresh data action
    private func handleRefreshData() {
        selectedAction = "Refreshing crypto data..."
        isRefreshing = true
        
        // Haptic feedback
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
        
        print("♻️ Refreshing all crypto data...")
        
        // Simulate data refresh
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isRefreshing = false
            selectedAction = "Data refreshed successfully!"
            showActionResult = true
            
            // Success feedback
            let notification = UINotificationFeedbackGenerator()
            notification.notificationOccurred(.success)
        }
    }
    
    // Handle view market action
    private func handleViewMarket() {
        selectedAction = "Opening market overview..."
        
        // Haptic feedback
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
        
        print("📊 Navigating to market view...")
        
        // Navigate after brief delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            navigateToMarket = true
        }
    }
    
    // Handle price history action
    private func handlePriceHistory() {
        selectedAction = "Loading price history..."
        
        // Haptic feedback
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
        
        print("📈 Loading price history...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showPriceHistory = true
        }
    }
    
    // Show price history alert
    private func showPriceHistoryAlert() {
        print("📊 Price history feature demonstrated")
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
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
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
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// Price History Sheet View
struct PriceHistorySheet: View {
    @Environment(\.dismiss) var dismiss
    
    let sampleData = [
        ("1 Day", "+2.45%", true),
        ("1 Week", "+8.32%", true),
        ("1 Month", "-3.12%", false),
        ("3 Months", "+15.67%", true),
        ("1 Year", "+145.23%", true)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // Header
                VStack(spacing: 10) {
                    Image(systemName: "chart.xyaxis.line")
                        .font(.system(size: 60))
                        .foregroundColor(.accentColor)
                    
                    Text("Bitcoin Price History")
                        .font(.title.bold())
                    
                    Text("Historical performance overview")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 30)
                
                // Price changes list
                VStack(spacing: 15) {
                    ForEach(sampleData, id: \.0) { period, change, isPositive in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(period)
                                    .font(.headline)
                                Text("Change")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 5) {
                                Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                                Text(change)
                                    .font(.title3.bold())
                            }
                            .foregroundColor(isPositive ? .green : .red)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Close button
                Button(action: { dismiss() }) {
                    Text("Close")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .navigationTitle("Price History")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}

#Preview("Price History") {
    PriceHistorySheet()
}
