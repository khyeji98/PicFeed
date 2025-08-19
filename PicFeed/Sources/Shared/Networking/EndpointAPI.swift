//
//  EndpointAPI.swift
//  PicFeed
//
//  Created by 김혜지 on 8/14/25.
//

import Foundation

enum Parameter {
    case json(Encodable)
    case multipart(boundary: String, datas: [Data], others: Encodable? = nil)
}

protocol EndpointAPI {
    associatedtype Response: Decodable
    
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameter: Parameter { get }
}

extension EndpointAPI {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Bundle.domain
        components.path = path
        return components.url
    }
    var httpBody: Data? {
        switch parameter {
        case .json(let encodable):
            return try? DataMapper.map(from: encodable)
        case .multipart(let boundary, let datas, let others):
            let mutableData = NSMutableData()
            let lineBreak = "\r\n"
            
            for data in datas {
                mutableData.appendString("--\(boundary)\(lineBreak)")
                mutableData.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(UUID().uuidString).jpg\"\(lineBreak)")
                mutableData.appendString("Content-Type: image/jpeg\(lineBreak)\(lineBreak)")
                mutableData.append(data)
                mutableData.appendString(lineBreak)
            }
            
            if let otherDict = others?.toDictionary() {
                for (key, value) in otherDict {
                    mutableData.appendString("--\(boundary)\(lineBreak)")
                    mutableData.appendString("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak)\(lineBreak)")
                    mutableData.appendString("\(value)\(lineBreak)")
                }
            }
            
            mutableData.appendString("--\(boundary)--\(lineBreak)")
            return mutableData as Data
        }
    }
}

private extension Bundle {
    static let domain: String = main.object(forInfoDictionaryKey: "SERVER_HOST") as? String ?? ""
}

private extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}

private extension Encodable {
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else { return nil }
        return dictionary
    }
}

