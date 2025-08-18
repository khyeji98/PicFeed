//
//  DataMapper.swift
//  PicFeed
//
//  Created by 김혜지 on 8/14/25.
//

import Foundation

enum DataMapper {
    static func map<T: Encodable>(from parameter: T) throws -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        encoder.keyEncodingStrategy = .useDefaultKeys
        
        let encoded = try encoder.encode(parameter)
        return encoded
    }
    
    public static func map<T: Decodable>(from data: Data, to response: T.Type) throws -> T {
        do {
            return try JSONDecoder().decode(response, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
}
