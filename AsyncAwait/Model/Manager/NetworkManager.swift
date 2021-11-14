//
//  NetworkManager.swift
//  AsyncAwait
//
//  Created by cmStudent on 2021/11/15.
//

import Foundation

final class NetworkManager {
    
    // MARK: - Properties
    static let shared = NetworkManager()
    
    
    // MARK: - Initialize
    private init() {}
    
    
    // MARK: - Methods
    func fetch<T: Codable>(_ url: URL, type: T.Type) async -> Result<T, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let typeObjects = try JSONDecoder().decode(T.self, from: data)
            return .success(typeObjects)
        } catch {
            return .failure(error)
        }
    }
    
}
