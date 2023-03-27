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
        
        var request = URLRequest(url: url)
#if !DEBUG
        request.allHTTPHeaderFields = ["X-App-Token": APP_TOKEN]
#endif
        let response: (Data, URLResponse)
        do {
            response = try await URLSession.shared.data(for: request)
        } catch {
            throw NetworkingError.custom(error: error)
        }
        
        let httpResponse = response.1 as! HTTPURLResponse
        guard (200...300) ~= httpResponse.statusCode else {
            throw NetworkingError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let data = try jsonDecoder.decode(T.self, from: response.0)
            return data
        } catch {
            throw NetworkingError.failedToDecode
        }
    }
}

extension NetworkingManager {
    enum NetworkingError: Error {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case failedToDecode
    }
}
