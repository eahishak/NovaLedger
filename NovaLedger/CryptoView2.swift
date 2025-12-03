//
//  CryptoView2.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import SwiftUI

struct CryptoView2: View {
    
    @State private var crypto: CryptoResponse?
    @State private var isLoading = true
    @State private var hasError = false
    
    private let service = CryptoService()
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            if isLoading {
                ProgressView("Loading market data...")
                    .scaleEffect(1.2)
            } else if hasError {
                errorView
            } else if let c = crypto {
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // Header
                        Text("Market Overview")
                            .font(.system(size: 38, weight: .bold))
                            .foregroundColor(Color("PrimaryNavy"))
                            .padding(.top, 20)
                        
                        Text(c.name)
                            .font(.title2)
                            .foregroundColor(.secondary)
                        
                        Divider()
                            .padding(.vertical, 10)
                        
                        // Market cap card
                        marketStatCard(
                            title: "Market Cap",
                            value: formatLargeNumber(c.market_data.usdMarketCap),
                            icon: "chart.bar.fill",
                            color: .blue
                        )
                        
                        // 24h high card
                        marketStatCard(
                            title: "24h High",
                            value: String(format: "$%.2f", c.market_data.usdHigh24h),
                            icon: "arrow.up.circle.fill",
                            color: .green
                        )
                        
                        // 24h low card
                        marketStatCard(
                            title: "24h Low",
                            value: String(format: "$%.2f", c.market_data.usdLow24h),
                            icon: "arrow.down.circle.fill",
                            color: .red
                        )
                        
                        // Price range visualization
                        VStack(spacing: 15) {
                            Text("24h Price Range")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            VStack(spacing: 8) {
                                HStack {
                                    Text("Low")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text("High")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        // Background bar
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(height: 10)
                                        
                                        // Current price indicator
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.accentColor)
                                            .frame(
                                                width: calculatePricePosition(
                                                    current: c.market_data.usdPrice,
                                                    low: c.market_data.usdLow24h,
                                                    high: c.market_data.usdHigh24h,
                                                    totalWidth: geometry.size.width
                                                ),
                                                height: 10
                                            )
                                    }
                                }
                                .frame(height: 10)
                                
                                HStack {
                                    Text(String(format: "$%.2f", c.market_data.usdLow24h))
                                        .font(.caption.bold())
                                    Spacer()
                                    Text(String(format: "$%.2f", c.market_data.usdHigh24h))
                                        .font(.caption.bold())
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                        
                        // Refresh button
                        Button(action: loadData) {
                            Label("Refresh Market Data", systemImage: "arrow.clockwise")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.top, 10)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .navigationTitle("Market Data")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadData()
        }
    }
    
    // Reusable market stat card
    private func marketStatCard(title: String, value: String, icon: String, color: Color) -> some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(color)
                .frame(width: 50, height: 50)
                .background(color.opacity(0.15))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.title2.bold())
                    .foregroundColor(Color("PrimaryNavy"))
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
    
    // Error state view
    private var errorView: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.red)
            
            Text("Failed to load market data")
                .font(.title2.bold())
            
            Text("Please check your connection and try again")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Button(action: loadData) {
                Text("Retry")
                    .font(.headline)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    
    // Load crypto data from API
    private func loadData() {
        isLoading = true
        hasError = false
        
        service.fetchBitcoin { result in
            isLoading = false
            
            if let result = result {
                self.crypto = result
            } else {
                self.hasError = true
            }
        }
    }
    
    // Format large numbers with abbreviations
    private func formatLargeNumber(_ number: Double) -> String {
        let billion = 1_000_000_000.0
        let million = 1_000_000.0
        
        if number >= billion {
            return String(format: "$%.2fB", number / billion)
        } else if number >= million {
            return String(format: "$%.2fM", number / million)
        } else {
            return String(format: "$%.2f", number)
        }
    }
    
    // Calculate price position on range bar
    private func calculatePricePosition(current: Double, low: Double, high: Double, totalWidth: CGFloat) -> CGFloat {
        guard high > low else { return 0 }
        let range = high - low
        let position = (current - low) / range
        return totalWidth * CGFloat(position)
    }
}

#Preview {
    NavigationStack {
        CryptoView2()
    }
}
