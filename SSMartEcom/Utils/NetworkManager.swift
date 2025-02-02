//
//  NetworkManager.swift
//  SSMartEcom
//
//  Created by siva chitran p on 01/02/25.
//

import Foundation

// MARK: - Error Handling
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(String)
    case noInternet
}


class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    
    // MARK: - Fetch Data using async/await
    func fetchData<T: Decodable>(type:T.Type,from endpoint: String) async throws -> T {
        
        let isConnected = await NetworkMonitor.shared.checkConnectivity()
        guard isConnected else {
            throw NetworkError.noInternet
        }
        
        guard let url = URL(string: "\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        do {
            print("API Response: \(data)")
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            print("Decoding Error: \(error.localizedDescription)")
            throw NetworkError.decodingError(error.localizedDescription)
        }
    }
}


