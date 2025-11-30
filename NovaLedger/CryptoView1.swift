//
//  CryptoView1.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import SwiftUI

struct CryptoView1: View {
    
    @State private var crypto: CryptoResponse?
    @State private var isLoading = true
    @State private var hasError = false
    
    private let service = CryptoService()
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            if isLoading {
                ProgressView("Loading...")
                    .scaleEffect(1.2)
            } else if hasError {
                errorView
            } else if let c = crypto {
                ScrollView {
                    VStack(spacing: 25) {
                        
                        // Crypto name header
                        Text(c.name)
                            .font(.system(size: 42, weight: .bold))
                            .foregroundColor(Color("PrimaryNavy"))
                            .padding(.top, 20)
                        
                        // Symbol badge
                        Text(c.formattedSymbol)
                            .font(.title2)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color.accentColor.opacity(0.2))
                            .cornerRadius(20)
                        
                        Divider()
                            .padding(.vertical, 10)
                        
                        // Current price card
                        VStack(spacing: 12) {
                            Text("Current Price")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Text("$\(c.market_data.usdPrice, specifier: "%.2f")")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(Color("PrimaryNavy"))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 25)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                        
                        // 24h price change card
                        VStack(spacing: 12) {
                            Text("24h Change")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            HStack(spacing: 8) {
                                Image(systemName: c.market_data.isPriceIncreasing ? "arrow.up.right" : "arrow.down.right")
                                    .font(.title2)
                                
                                Text(c.market_data.formattedPriceChange)
                                    .font(.system(size: 36, weight: .semibold))
                            }
                            .foregroundColor(c.market_data.isPriceIncreasing ? .green : .red)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 25)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                        
                        // Refresh button
                        Button(action: loadData) {
                            Label("Refresh Data", systemImage: "arrow.clockwise")
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
        .navigationTitle("Crypto Status")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadData()
        }
    }
    
    // Error state view
    private var errorView: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.red)
            
            Text("Failed to load data")
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
}

#Preview {
    NavigationStack {
        CryptoView1()
    }
}
