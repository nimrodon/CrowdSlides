//
//  MainView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 06/12/2024.
//

import SwiftUI

struct SlideshowView: View {
    
    @StateObject private var slideshowVM = SlideshowViewModel()
    @EnvironmentObject var sharedDBService: SharedDBService
    @EnvironmentObject var slideshowDataService: SlideshowDataService
    
    var body: some View {
        VStack {
            if slideshowVM.slides.isEmpty {
                Text("Loading...")
                    .bodyTextStyle()
            }
            else {
                SlideView(slide: slideshowVM.slides[slideshowVM.currentSlideIndex])
            }
        }
        .onAppear {
            slideshowVM.configure(sharedDBService: sharedDBService,
                                  slideshowDataService: slideshowDataService)
        }
        .environmentObject(slideshowVM)
        .environment(\.layoutDirection, getLayoutDirection())
        .screenDefinitions()
    }
    
    
    private func getLayoutDirection() -> LayoutDirection {
        return slideshowVM.settings.isRTL == true ? .rightToLeft : .leftToRight
    }

}

#Preview {
    SlideshowView()
}
