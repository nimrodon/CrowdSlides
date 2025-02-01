//
//  SlideView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 07/12/2024.
//

import SwiftUI

struct SlideView: View {
    
    @EnvironmentObject var slideshowVM: SlideshowViewModel
    var slide: Slide
    
    var body: some View {
        VStack {
            switch slide {

                case .intro(let introSlide):
                    IntroSlideView(slide: introSlide,
                                   settings: slideshowVM.settings,
                                   numOfUsers: slideshowVM.numOfUsers)

                case .story(let storySlide):
                    StorySlideView(slide: storySlide)

                case .selection(let selectionSlide):
                    SelectionSlideView(slide: selectionSlide)

                case .ending(let endingSlide):
                    EndingSlideView(slide: endingSlide,
                                    settings: slideshowVM.settings)
            }
        }
        .onChange(of: slide) { newSlide in
            handleSound(newSlide: newSlide)
        }
    }
    
    private func handleSound(newSlide: Slide) {
        if let stopAllSounds = newSlide.base.stopAllSounds, stopAllSounds {
            slideshowVM.stopAllSounds()
        }
        slideshowVM.playSlideSound()
    }
}


