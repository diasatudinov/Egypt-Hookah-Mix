//
//  GradientText.swift
//  Egypt Hookah Mix
//
//

import SwiftUI

struct GradientText: View {
    let text: String
    let font: Font
    var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(
                LinearGradient(
                    colors: [.gradientLeading, .gradientTrailing],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}

struct GradientStrokeText: View {
    let text: String
    var font: Font = .title
    
    var body: some View {
        ZStack {
            // Черная обводка
            ForEach(0..<8) { index in
                let angle = Double(index) / 8.0 * 2.0 * Double.pi
                Text(text)
                    .font(font)
                    .foregroundColor(.black)
                    .offset(
                        x: CGFloat(cos(angle)) * 2,
                        y: CGFloat(sin(angle)) * 2
                    )
            }
            
            // Градиентная заливка внутри
            Text(text)
                .font(font)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.gradientLeading, .gradientTrailing],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
    }
}

struct StrokeText: View {
    let text: String
    var font: Font = .title
    var color: Color = .white
    var body: some View {
        ZStack {
            // Черная обводка
            ForEach(0..<8) { index in
                let angle = Double(index) / 8.0 * 2.0 * Double.pi
                Text(text)
                    .font(font)
                    .foregroundColor(.black)
                    .offset(
                        x: CGFloat(cos(angle)) * 2,
                        y: CGFloat(sin(angle)) * 2
                    )
            }
            
            // Градиентная заливка внутри
            Text(text)
                .font(font)
                .foregroundStyle(color)
        }
    }
}
