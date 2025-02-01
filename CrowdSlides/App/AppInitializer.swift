//
//  AppInitializer.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 28/01/2025.
//

import Foundation

class AppInitializer {
    
    private let sharedDBService: SharedDBService
    private let slideshowDataService: SlideshowDataService
    
    
    init(sharedDBService: SharedDBService,
         slideshowDataService: SlideshowDataService)
    {
        self.sharedDBService = sharedDBService
        self.slideshowDataService = slideshowDataService
        initDB()
        initUI()
    }

    
    private func initDB() {
        let clientConfig = slideshowDataService.getClientConfig()
        sharedDBService.setClientConfig(clientConfig)
        sharedDBService.setIsVoting(false)
        sharedDBService.clearUsers()
    }

    
    private func initUI() {
        let settings = slideshowDataService.getSettings()
        FontManager.initSlideshowRegularFont(fontName: settings.regularFontName)
        FontManager.initSlideshowBoldFont(fontName: settings.boldFontName)
        StyleGuide.Color.setPrimaryColor(hex: settings.primaryColor)
        StyleGuide.Color.setBackgroundColor(hex: settings.backgroundColor)
        StyleGuide.Color.setPanelBackgroundColor(hex: settings.panelBackgroundColor)
    }
}
