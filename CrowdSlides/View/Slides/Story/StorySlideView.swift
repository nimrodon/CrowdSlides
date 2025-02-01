//
//  StorySlideView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 07/12/2024.
//

import SwiftUI

struct StorySlideView: View {
    
    let slide: StorySlide
    let screenHeight = NSScreen.main?.frame.height ?? 0
    let screenWidth = NSScreen.main?.frame.width ?? 0

    var body: some View {
        
        ZStack {
            if let videoFile = slide.videoFile {
                VideoPlayerView(videoFile: videoFile)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            else if let fileName = slide.backgroundImage {
                SlideBackgroundImageView(fileName: fileName)
            }
            
            if let slideText = slide.text {
                SlideText(text: slideText,
                          isBackground: slide.backgroundUnderText)
                    .position(CGPoint(x: screenWidth / 2, y: slide.textYPos ?? screenHeight / 2))
            }

        }
    }
}

#Preview {
    StorySlideView(slide: StorySlide(
        id: "1",
        nextSlideId: "2",
        backgroundImage: "bed_ants.webp",
        sound: nil,
        stopAllSounds: nil,
        videoFile: nil,
        text: "This is a story slide",
        backgroundUnderText: true,
        textYPos: nil
    ))
    .frame(width: 1920, height: 1080)
    .previewLayout(.fixed(width: 1920, height: 1080))
}
