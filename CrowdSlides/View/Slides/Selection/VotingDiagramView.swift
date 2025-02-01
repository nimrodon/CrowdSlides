//
//  VotingDiagramView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 17/12/2024.
//

import SwiftUI
import Combine

struct VotingDiagramView: View {
    
    let optionTitles: [String]
    let votes: [Int]
    let numOfUsers: Int
    let colors: [Color]
    
    var maxVotesPerColumn: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                ForEach(optionTitles.indices, id: \.self) { index in
                    VotingColumnView(color: colors[index],
                                     title: optionTitles[index],
                                     voteCount: votes[index],
                                     fillPercentage: calcColumnFillPercentage(voteCount: votes[index]))
                    .frame(maxWidth: .infinity)
                }
            }
            .storyTextStyle()
            .frame(maxWidth: .infinity)
        }
    }

    
    private func calcColumnFillPercentage(voteCount: Int) -> Double  {
        let maxVotesPerColumn = max(numOfUsers / votes.count, votes.max() ?? 0)
        let fillPercentage = maxVotesPerColumn != 0 ? Double(voteCount) / Double(maxVotesPerColumn) : 0.0
        return fillPercentage
        

    }
}

#Preview {
    VStack {
        VotingDiagramView(optionTitles: ["feed the cat", "kill the bird", "go to sleep"], votes: [15,10,7], numOfUsers: 30, colors: SlideshowSettings.defaults.selectionSettings.votingDiagramColors.map({ colorStr in
            return ColorHelper.colorFromHex(colorStr)
        }))
    }
    .frame(width: 1920, height: 1080)
    .border(Color.red) 
}
