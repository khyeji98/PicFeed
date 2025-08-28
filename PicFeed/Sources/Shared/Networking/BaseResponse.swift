//
//  BaseResponse.swift
//  PicFeed
//
//  Created by 김혜지 on 8/19/25.
//

struct BaseResponse<T: Decodable>: Decodable {
    let code: Int
    let data: T
}
