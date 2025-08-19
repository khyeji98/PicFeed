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
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(response, from: data)
        } catch {
            if let prettyPrintedJSON = data.prettyPrintedJSON {
                print(prettyPrintedJSON)
            }
            throw NetworkError.invalidData
        }
    }
}

private extension Data {
    var utf8String: String? { String(data: self, encoding: .utf8) }
    
    var prettyPrintedJSON: String? {
        guard
            let obj = try? JSONSerialization.jsonObject(with: self),
            let data = try? JSONSerialization.data(withJSONObject: obj, options: [.prettyPrinted]),
            let str = String(data: data, encoding: .utf8)
        else { return nil }
        return str
    }
}
