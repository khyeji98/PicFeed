//
//  ResultView.swift
//  PicFeed
//
//  Created by 김혜지 on 8/19/25.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) var dismiss
    
    private let uiImage: UIImage
    private let result: AnalyzeResult
    
    init(uiImage: UIImage, result: AnalyzeResult) {
        self.uiImage = uiImage
        self.result = result
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "multiply")
                        .resizable()
                        .scaledToFit()
                }
                .foregroundColor(.black)
                .frame(width: 20)
            }
            .padding(.horizontal, 14)
            
            ScrollView(.vertical) {
                VStack(spacing: 30) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                    VStack(spacing: 15) {
                        ResultComponentCard(
                            title: result.composition.title,
                            score: result.composition.score,
                            reason: result.composition.reason
                        )
                        ResultComponentCard(
                            title: result.exposure.title,
                            score: result.exposure.score,
                            reason: result.exposure.reason
                        )
                        ResultComponentCard(
                            title: result.color.title,
                            score: result.color.score,
                            reason: result.color.reason
                        )
                        ResultComponentCard(
                            title: result.subjectClarity.title,
                            score: result.subjectClarity.score,
                            reason: result.subjectClarity.reason
                        )
                        ResultComponentCard(
                            title: result.mood.title,
                            score: result.mood.score,
                            reason: result.mood.reason
                        )
                    }
                }
                .padding(20)
            }
        }
    }
}

private struct ResultComponentCard: View {
    private let title: String
    private let score: Double
    private let reason: String
    
    private var color: Color {
        switch score {
        case ..<2: return .red
        case ..<4: return .yellow
        default: return .green
        }
    }
    
    init(
        title: String,
        score: Double,
        reason: String
    ) {
        self.title = title
        self.score = score
        self.reason = reason
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(color.opacity(0.2))
            
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 2)
                .foregroundStyle(color)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .foregroundStyle(.black.opacity(0.5))
                    Text(score.formatted(FloatingPointFormatStyle()))
                        .font(.title3)
                        .bold()
                    
                    Spacer()
                }
                
                Text(reason)
            }
            .padding(20)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    ResultView(uiImage: UIImage(systemName: "photo")!, result: .mock)
}
