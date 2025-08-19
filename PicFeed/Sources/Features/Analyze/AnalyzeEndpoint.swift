//
//  AnalyzeEndpoint.swift
//  PicFeed
//
//  Created by 김혜지 on 8/18/25.
//

import Foundation

struct AnalyzeEndpoint: EndpointAPI {
    typealias Response = AnalyzeResponse
    
    let path: String
    let method: HTTPMethod
    let headers: [String: String]
    let parameter: Parameter
    
    private let boundary: String = "Boundary-\(UUID().uuidString)"
    
    init(imageData: Data) {
        self.path = "/upload"
        self.method = .post
        self.headers = [
            "X-API-Key": Bundle.apiKey,
            "Accept": "application/json",
            "Content-Type": "multipart/form-data; boundary=\(boundary)"
        ]
        self.parameter = .multipart(boundary: boundary, datas: [imageData], others: Config(dev: true))
    }
    
    private struct Config: Encodable {
        let dev: Bool
    }
}

struct BaseResponse<T: Decodable>: Decodable {
    let code: Int
    let data: T
}

struct AnalyzeResponse: Decodable {
    let composition: Detail
    let exposure: Detail
    let color: Detail
    let subjectClarity: Detail
    let mood: Detail
}

extension AnalyzeResponse {
    struct Detail: Decodable {
        let score: Double
        let reason: String
    }
}

private extension Bundle {
    static let apiKey: String = main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
}
