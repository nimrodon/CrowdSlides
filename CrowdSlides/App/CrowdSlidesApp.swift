//
//  crowdSlidesApp.swift
//  crowdSlides
//
//  Created by Nimrod Yizhar on 04/12/2024.
//

import SwiftUI

@main
struct crowdSlidesApp: App {
    
    let sharedDBService: SharedDBService
    let slideshowDataService: SlideshowDataService
    
    
    var body: some Scene {
        WindowGroup {
            SlideshowView()
                .environmentObject(sharedDBService)
                .environmentObject(slideshowDataService)
        }
        .defaultSize(width: 1920, height: 1080)
    }

    
    init() {

        sharedDBService = SharedDBService()
        slideshowDataService = SlideshowDataService()
        
        let _ = AppInitializer(sharedDBService: sharedDBService,
                                            slideshowDataService: slideshowDataService)
    }

}
