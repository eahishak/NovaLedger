//
//  CryptoModel.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//
import Foundation

struct CryptoResponse: Decodable {
    let name: String
    let symbol: String
    let market_data: MarketData
}

struct MarketData: Decodable {
    let current_price: [String: Double]
    let high_24h: [String: Double]
    let low_24h: [String: Double]
    let market_cap: [String: Double]
    let price_change_percentage_24h: Double
}
