//
//  SelectionLiveResultsView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 08/12/2024.
//

import Foundation
import SwiftUI

struct SelectionVotingView: View {
    
    @EnvironmentObject var selectionVM: SelectionSlideViewModel
    let settings: SlideshowSelectionSettings
    let slide: SelectionSlide
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer(minLength: geometry.size.height * 0.04)

                Text(slide.text)
                    .selectionTextStyle()
                    .frame(height: geometry.size.height * 0.05)

                Spacer(minLength: geometry.size.height * 0.04)

                Text(settings.votePromptText)
                    .selectionPromptTextStyle()
                    .frame(height: geometry.size.height * 0.04)

                Spacer(minLength: geometry.size.height * 0.05)

                IntegerWithCaptionView(caption: settings.timerText,
                                       value: selectionVM.votingTimeLeft)
                .selectionTimerTextStyle()
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height * 0.03)

                Spacer(minLength: geometry.size.height * 0.05)
                
                VotingDiagramView(optionTitles: slide.options.map({$0.text}),
                                  votes: selectionVM.votes,
                                  numOfUsers: selectionVM.numOfUsers,
                                  colors: ColorHelper.colorsFromHexes(settings.votingDiagramColors))
                .frame(maxWidth: geometry.size.width * 0.8, maxHeight: geometry.size.height * 0.60)
                
                Spacer(minLength: geometry.size.height * 0.1)

            }
            .onAppear() {
                selectionVM.handleSound()
            }
        }
    }
}
