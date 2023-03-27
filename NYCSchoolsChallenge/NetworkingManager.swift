//
//  NetworkingManager.swift
//  NYCSchoolsChallenge
//
//  Created by Kuba Szulaczkowski on 3/26/23.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Decodable>(_ absoluteURL: String) async throws -> T {
        guard let url = URL(string: absoluteURL) else { throw NetworkingError.invalidURL }
        
        let response = try await URLSession.shared.data(from: url)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try jsonDecoder.decode(T.self, from: response.0)
    }
}

extension NetworkingManager {
    enum NetworkingError: Error {
        case invalidURL
    }
}
