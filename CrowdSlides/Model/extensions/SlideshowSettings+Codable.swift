//
//  SlideshowSettings+Codable.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 28/01/2025.
//

import Foundation

extension SlideshowSettings {
    
    enum CodingKeys: String, CodingKey {
        case isRTL
        case regularFontName
        case boldFontName
        case primaryColor
        case backgroundColor
        case panelBackgroundColor
        case numOfUsersText
        case theEndText
        case selectionSettings
        case startSlideId
    }

    
    init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)

         self.isRTL = try container.decodeIfPresent(Bool.self, forKey: .isRTL) ?? SlideshowSettings.defaults.isRTL
         self.regularFontName = try container.decodeIfPresent(String.self, forKey: .regularFontName) ?? SlideshowSettings.defaults.regularFontName
         self.boldFontName = try container.decodeIfPresent(String.self, forKey: .boldFontName) ?? SlideshowSettings.defaults.boldFontName
         self.primaryColor = try container.decodeIfPresent(String.self, forKey: .primaryColor) ?? SlideshowSettings.defaults.primaryColor
         self.backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor) ?? SlideshowSettings.defaults.backgroundColor
         self.panelBackgroundColor = try container.decodeIfPresent(String.self, forKey: .panelBackgroundColor) ?? SlideshowSettings.defaults.panelBackgroundColor
         self.numOfUsersText = try container.decodeIfPresent(String.self, forKey: .numOfUsersText) ?? SlideshowSettings.defaults.numOfUsersText
         self.theEndText = try container.decodeIfPresent(String.self, forKey: .theEndText) ?? SlideshowSettings.defaults.theEndText
         self.selectionSettings = try container.decodeIfPresent(SlideshowSelectionSettings.self, forKey: .selectionSettings) ?? SlideshowSettings.defaults.selectionSettings
         self.startSlideId = try container.decodeIfPresent(String.self, forKey: .startSlideId) ?? SlideshowSettings.defaults.startSlideId
     }
}
