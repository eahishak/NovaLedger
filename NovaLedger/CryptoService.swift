//
//  CryptoService.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import Foundation

class CryptoService {
    func fetchBitcoin(completion: @escaping (CryptoResponse?) -> Void) {
        let urlString = "https://api.coingecko.com/api/v3/coins/bitcoin"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                let result = try? JSONDecoder().decode(CryptoResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
