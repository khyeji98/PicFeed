//
//  AnalyzeViewModel.swift
//  PicFeed
//
//  Created by 김혜지 on 8/18/25.
//

import Foundation

@MainActor
@Observable
final class AnalyzeViewModel {
    private(set) var isLoading: Bool = false
    var analyzeResult: AnalyzeResult? = nil
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func analyze(imageData: Data) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            analyzeResult = nil
            let endpoint = AnalyzeEndpoint(imageData: imageData)
            let data = try await networkClient.request(from: endpoint)
            let result = try DataMapper.map(from: data, to: AnalyzeEndpoint.Response.self)
            analyzeResult = result.toModel()
            print(result)
        } catch {
            print(error)
        }
    }
}
