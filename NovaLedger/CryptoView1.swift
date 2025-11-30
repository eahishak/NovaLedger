//
//  CryptoView1.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import SwiftUI

struct CryptoView1: View {

    @State private var crypto: CryptoResponse?
    private let service = CryptoService()

    var body: some View {
        VStack(spacing: 20) {
            if let c = crypto {

                Text(c.name)
                    .font(.largeTitle.bold())
                    .foregroundColor(Color("PrimaryNavy"))

                Text("Symbol: \(c.symbol.uppercased())")
                    .font(.title2)

                Text("Current Price: $\(c.market_data.current_price["usd"] ?? 0.0, specifier: "%.2f")")
                    .font(.title2)

                Text("24h Change: \(c.market_data.price_change_percentage_24h, specifier: "%.2f")%")
                    .foregroundColor(c.market_data.price_change_percentage_24h >= 0 ? .green : .red)
                    .font(.title3)

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
        .navigationTitle("Crypto Status")
    }
}

#Preview {
    CryptoView1()
}
