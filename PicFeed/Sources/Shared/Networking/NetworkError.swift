//
//  NetworkError.swift
//  PicFeed
//
//  Created by 김혜지 on 8/14/25.
//


import Foundation

public enum NetworkError: Error {
    case invalidURL
    case invalidData
    case invalidURLResponse
    case statusCode(Int, Data)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        "일시적인 오류가 발생했습니다.\n잠시후 다시 시도해 주세요."
    }
}
