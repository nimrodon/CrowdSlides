//
//  ConcreteSlides.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 05/12/2024.
//

import Foundation

struct IntroSlide: SlideBase {

    let id: String

    let nextSlideId: String?

    let backgroundImage: String?

    let sound: Sound?

    let stopAllSounds: Bool?

    // slideshow title
    let titleText: String

    // invitation to join
    let inviteText: String

    // QR code that leads to the html client
    let QRCodeImage: String

}


struct StorySlide: SlideBase {

    let id: String

    let nextSlideId: String?

    let backgroundImage: String?

    let sound: Sound?

    let stopAllSounds: Bool?

    // video file to be displayed
    let videoFile: String?

    // free text
    let text: String?

    // flag - background under text. To improve readbility of text when it is over a colorful background image
    let backgroundUnderText: Bool?
    
    // absolute y coordinates of text view (where the center of the text is placed)
    let textYPos: Double?
}


struct SelectionSlide: SlideBase {
    
    let id: String
    
    let nextSlideId: String? 
    
    let backgroundImage: String?
    
    let sound: Sound?
    
    let stopAllSounds: Bool?

    // description of the subject to vote on
    let text: String
    
    // flag - background under text. To improve readbility of text when it is over a colorful background image
    let backgroundUnderText: Bool?

    // description of the selection subject, for the html client. if nil, "text" property will be used
    let clientText: String?
    
    // time in seconds, for voting
    let selectionDuration: Int
    
    // options to vote
    let options: [SelectionSlideOption]
    
}


struct SelectionSlideOption: Codable {

    // option description
    let text: String

    // option description, for html client. if nil, "text" property will be used
    let clientText: String?

    // slide id to jump to, if this option won the voting
    let nextSlideId: String
}
 

struct EndingSlide: SlideBase {

    let id: String

    let nextSlideId: String?

    let backgroundImage: String?

    let sound: Sound?

    let stopAllSounds: Bool?

}

