//
//  EndpointAPI.swift
//  PicFeed
//
//  Created by 김혜지 on 8/14/25.
//

import Foundation

enum Parameter {
    case json(Encodable)
    case multipart(boundary: String, [Data])
}

protocol EndpointAPI {
    associatedtype Response: Decodable
    
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameter: Parameter { get }
    var responseBody: Response { get }
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
        case .multipart(let boundary, let datas):
            let mutableData = NSMutableData()
            for data in datas {
                mutableData.appendString("--\(boundary)\r\n")
                mutableData.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(UUID().uuidString).jpeg\"\r\n")
                mutableData.appendString("Content-Type: image/jpeg\r\n\r\n")
                mutableData.append(data)
                mutableData.appendString("\r\n")
            }
            mutableData.appendString("--\(boundary)--")
            return mutableData as Data
        }
    }
    
    var response: Response.Type { Response.self }
}

private extension Bundle {
    static let domain: String = main.infoDictionary?["SERVER_HOST"] as? String ?? ""
}

private extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
