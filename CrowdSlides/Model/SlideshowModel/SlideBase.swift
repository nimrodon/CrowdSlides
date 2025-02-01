//
//  SlideBase.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 05/12/2024.
//

import Foundation

protocol SlideBase: Codable {

    var id: String { get }

    // if nextSlideId is nil, next slide will be the next in the slideshow
    var nextSlideId: String? { get }

    // image to be displayed as the slide background
    var backgroundImage: String? { get }

    // sound that will be played when slide is displayed
    var sound: Sound? { get }

    // flag - stop all current playing sounds when slide is displayed
    var stopAllSounds: Bool? { get } 
}
