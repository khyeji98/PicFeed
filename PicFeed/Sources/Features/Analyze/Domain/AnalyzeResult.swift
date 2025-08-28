//
//  AnalyzeResult.swift
//  PicFeed
//
//  Created by 김혜지 on 8/19/25.
//

import Foundation

struct AnalyzeResult: Identifiable {
    let id = UUID()
    let composition: Detail
    let exposure: Detail
    let color: Detail
    let subjectClarity: Detail
    let mood: Detail
}

extension AnalyzeResult {
    struct Detail {
        let title: String
        let score: Double
        let reason: String
    }
}

extension AnalyzeResult {
    static let mock = AnalyzeResult(
        composition: Detail(title: "구도", score: 0.5, reason: ""),
        exposure: Detail(title: "노출", score: 0.5, reason: ""),
        color: Detail(title: "색감", score: 0.5, reason: ""),
        subjectClarity: Detail(title: "주제 선명도", score: 0.5, reason: ""),
        mood: Detail(title: "분위기", score: 0.5, reason: "")
    )
}
