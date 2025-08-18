//
//  NetworkClient.swift
//  PicFeed
//
//  Created by 김혜지 on 8/14/25.
//

import Foundation

protocol NetworkClient {
    func request(from endpoint: some EndpointAPI) async throws -> Data
}
