//
//  CryptoView2.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import SwiftUI

struct CryptoView2: View {

    @State private var crypto: CryptoResponse?
    private let service = CryptoService()

    var body: some View {
        VStack(spacing: 25) {
            if let c = crypto {

                Text("Market Overview")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color("PrimaryNavy"))

                Text("Market Cap: $\(c.market_data.market_cap["usd"] ?? 0, specifier: "%.0f")")
                    .font(.title3)

                Text("24h High: $\(c.market_data.high_24h["usd"] ?? 0.0, specifier: "%.2f")")

                Text("24h Low: $\(c.market_data.low_24h["usd"] ?? 0.0, specifier: "%.2f")")

            } else {
                ProgressView("Loading...")
            }
        }
        .padding()
        .onAppear {
            service.fetchBitcoin { result in
                self.crypto = result
            }
        }
        .navigationTitle("Market Data")
    }
}

#Preview {
    CryptoView2()
}
