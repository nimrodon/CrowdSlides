//
//  VotingColumnView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 17/12/2024.
//

import SwiftUI

struct VotingColumnView: View {
    
    let color: Color
    let title: String
    let voteCount: Int
    let fillPercentage: Double
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                VStack(alignment: .center ){
                    VStack {
                        Spacer()
                        Text("\(voteCount)")
                            .mainTitleTextStyle()
                            .foregroundColor(.secondary)
                            .frame(height: geometry.size.height * 0.15)
                        Rectangle()
                            .fill(color)
                            .frame(height: geometry.size.height * 0.7 * fillPercentage)
                    }
                    .frame(width: 200, height: geometry.size.height * 0.85)
                    
                    Text(title)
                        .lineLimit(1)
                        .storyTextStyle()
                        .foregroundColor(.primary)
                        .frame(height: geometry.size.height * 0.15)
                }
                .frame(width: 400)
                Spacer()
            }
        }
    }
}

#Preview {
    VStack {
        VotingColumnView(color: Color.yellow, title: "Fix the sink", voteCount: 3, fillPercentage: 0.6)
            .previewLayout(.fixed(width: 1920, height: 1080))
            .screenDefinitions()

    }
    .frame(width: 1920, height: 1080)
    .border(Color.red) 
    
}
