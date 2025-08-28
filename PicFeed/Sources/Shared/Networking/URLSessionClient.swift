//
//  URLSessionClient.swift
//  PicFeed
//
//  Created by 김혜지 on 8/14/25.
//

import Foundation

final class URLSessionClient: NetworkClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request(from endpoint: some EndpointAPI) async throws -> Data {
        do {
            guard let url = endpoint.url else { throw NetworkError.invalidURL }
            
            // 1. Make URLRequest
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = endpoint.method.rawValue
            endpoint.headers.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
            urlRequest.httpBody = endpoint.httpBody
            
            #if DEBUG
            if let body = endpoint.httpBody {
                print("Body size: \(body.count) bytes (\(Double(body.count) / 1024.0 / 1024.0) MB)")
            } else {
                print("No httpBody")
            }
            #endif
            
            // 2. Reqeust Networking
            let (data, response) = try await session.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.invalidURLResponse }
            guard 200..<300 ~= response.statusCode else { throw NetworkError.statusCode(response.statusCode, data) }
            
            print("""
                Networking Success
                request spec : \(urlRequest)
                response : \(data) \(response)
                """)
            
            return data
        } catch {
            print("""
                Networking Error
                error : \(error)
                """)
            throw error
        }
    }
}
