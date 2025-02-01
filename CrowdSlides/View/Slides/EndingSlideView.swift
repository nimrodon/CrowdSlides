//
//  EndingSlideView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 08/12/2024.
//

import SwiftUI

struct EndingSlideView: View {
    
    let slide: EndingSlide
    let settings: SlideshowSettings
    
    var body: some View {
        ZStack {
            if let fileName = slide.backgroundImage {
                SlideBackgroundImageView(fileName: fileName)
            }
            VStack {
                Text(settings.theEndText)
                    .theEndTextStyle()
            }
        }
    }
}

#Preview {
    EndingSlideView(slide: EndingSlide(
        id: "1",
        nextSlideId: nil,
        backgroundImage: "title_frame.webp",
        sound: nil,
        stopAllSounds: true
    ), settings: SlideshowSettings.defaults)
    .frame(width: 1920, height: 1080)
    .previewLayout(.fixed(width: 1920, height: 1080))
}
