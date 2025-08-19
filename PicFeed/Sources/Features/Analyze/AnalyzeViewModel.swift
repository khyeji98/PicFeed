//
//  AnalyzeViewModel.swift
//  PicFeed
//
//  Created by 김혜지 on 8/18/25.
//

import Foundation

@Observable
final class AnalyzeViewModel {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func analyze(imageData: Data) async {
        do {
            let endpoint = AnalyzeEndpoint(imageData: imageData)
            let data = try await networkClient.request(from: endpoint)
            let result = try DataMapper.map(from: data, to: AnalyzeEndpoint.Response.self)
            print(result)
        } catch {
            print(error)
        }
    }
}
