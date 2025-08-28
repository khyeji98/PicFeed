//
//  AnalyzeResponse.swift
//  PicFeed
//
//  Created by 김혜지 on 8/19/25.
//

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

extension AnalyzeResponse {
    func toModel() -> AnalyzeResult {
        AnalyzeResult(
            composition: composition.toModel(title: "구도"),
            exposure: exposure.toModel(title: "노출"),
            color: color.toModel(title: "색감"),
            subjectClarity: subjectClarity.toModel(title: "주제 선명도"),
            mood: mood.toModel(title: "분위기")
        )
    }
    
}

extension AnalyzeResponse.Detail {
    func toModel(title: String) -> AnalyzeResult.Detail {
        AnalyzeResult.Detail(title: title, score: score, reason: reason)
    }
}
