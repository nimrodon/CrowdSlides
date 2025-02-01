//
//  SelectionSlideView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 08/12/2024.
//

import Foundation
import SwiftUI

struct SelectionSlideView: View {
    
    @StateObject var selectionVM = SelectionSlideViewModel()
    @EnvironmentObject var slideshowVM: SlideshowViewModel
    @EnvironmentObject var sharedDBService: SharedDBService

    let slide: SelectionSlide
    
    var body: some View {
        ZStack {
            if let fileName = slide.backgroundImage {
                SlideBackgroundImageView(fileName: fileName)
            }

            if let isBackground = slide.backgroundUnderText, isBackground == true {
                BlurredRectView()
            }

            VStack {
                ZStack {
                    switch selectionVM.currentPhase {
                        case .presentation:
                            SelectionPresentationView(slide: slide)
                        case .voting,
                             .showResults:
                            SelectionVotingView(settings: selectionVM.settings,
                                                slide: slide)
                    }
                    
                    if selectionVM.currentPhase == .showResults {
                        SelectionResultsView(slide: slide)
                    }
                }
                
                Spacer(minLength: CGFloat(selectionVM.settings.verticalSpaceFromBottom))
            }
        }
        .onAppear() {
            selectionVM.configure(sharedDBService: sharedDBService,
                                  slide: slide,
                                  settings: slideshowVM.settings.selectionSettings,
                                  selectionCompletedHandler: slideshowVM.handleSelectionCompleted)
            slideshowVM.selectionInputDelegate = selectionVM
        }
        .onDisappear() {
            slideshowVM.selectionInputDelegate = nil
        }
        .environmentObject(selectionVM)
    }
}
