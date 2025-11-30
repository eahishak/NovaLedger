//
//  CryptoService.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import Foundation

class CryptoService {
    
    private let baseURL = "https://api.coingecko.com/api/v3/coins"
    
    // Fetch Bitcoin data from CoinGecko API
    func fetchBitcoin(completion: @escaping (CryptoResponse?) -> Void) {
        let urlString = "\(baseURL)/bitcoin"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Check for network errors
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            // Validate HTTP response
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                print("HTTP error: Status code \(httpResponse.statusCode)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            // Parse JSON data
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let cryptoData = try decoder.decode(CryptoResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(cryptoData)
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
    
    // Fetch data for any cryptocurrency by ID
    func fetchCrypto(id: String, completion: @escaping (CryptoResponse?) -> Void) {
        let urlString = "\(baseURL)/\(id)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let cryptoData = try decoder.decode(CryptoResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(cryptoData)
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
