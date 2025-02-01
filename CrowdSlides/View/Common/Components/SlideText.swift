//
//  SlideText.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 26/01/2025.
//

import SwiftUI

struct SlideText: View {
    
    let text: String
    let isBackground: Bool?

    var body: some View {
        ZStack {
            if let isBackground = isBackground, isBackground == true {
                BlurredRectView()
            }
            Text(text)
                .storyTextStyle()
                .multilineTextAlignment(.center)
                .padding(16)
        }
        .fixedSize(horizontal: true, vertical: true)
    }
}

#Preview {
    SlideText(text: "hello", isBackground: true)
}
