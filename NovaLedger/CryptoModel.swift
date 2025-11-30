//
//  CryptoModel.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import Foundation

// Main response structure from CoinGecko API
struct CryptoResponse: Decodable {
    let name: String
    let symbol: String
    let market_data: MarketData
    
    // Computed property for formatted symbol
    var formattedSymbol: String {
        symbol.uppercased()
    }
}

// Market data containing price and statistics
struct MarketData: Decodable {
    let current_price: [String: Double]
    let high_24h: [String: Double]
    let low_24h: [String: Double]
    let market_cap: [String: Double]
    let price_change_percentage_24h: Double
    
    // Helper to get USD price safely
    var usdPrice: Double {
        current_price["usd"] ?? 0.0
    }
    
    var usdHigh24h: Double {
        high_24h["usd"] ?? 0.0
    }
    
    var usdLow24h: Double {
        low_24h["usd"] ?? 0.0
    }
    
    var usdMarketCap: Double {
        market_cap["usd"] ?? 0.0
    }
    
    // Determine if price change is positive
    var isPriceIncreasing: Bool {
        price_change_percentage_24h >= 0
    }
    
    // Formatted percentage string
    var formattedPriceChange: String {
        String(format: "%.2f%%", price_change_percentage_24h)
    }
}
