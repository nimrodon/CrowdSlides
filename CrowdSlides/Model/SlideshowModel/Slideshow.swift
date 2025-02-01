//
//  Slideshow.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 05/12/2024.
//

import Foundation

struct Slideshow: Codable {
    
    let slides: [Slide]
    
    let settings: SlideshowSettings
   
}


struct SlideshowSettings: Codable {

    // is view formatting done from right to left (for slideshows in Hebrew, Arabic and such)
    let isRTL: Bool

    // font used for normal text
    let regularFontName: String
    
    // font used for bold text
    let boldFontName: String

    // color of text in slides (HEX)
    let primaryColor: String

    // background color of slides (HEX)
    let backgroundColor: String

    // background color of panels in slides (HEX)
    let panelBackgroundColor: String

    // caption of number of uses, shown in "Intro" slide
    let numOfUsersText: String

    //  "the end" message, shown in "Ending" slide
    let theEndText: String

    // settings relevant for "Selection" slides
    let selectionSettings: SlideshowSelectionSettings
    
    // Slide id to start with - a fast way to view a slide, when creating the slideshow.
    let startSlideId: String?

}


struct SlideshowSelectionSettings: Codable {

    // number of pixels to raise the selection slide, for cases where people or objects are obstructing the view (e. g., in theaters or stages).
    let verticalSpaceFromBottom: Int

    // "prepare to vote" text, in selection presentation phase
    let preparePromptText: String
    
    // the word "or" for showing options. needed configuration for non-english localization. in selection presentation phase
    let orText: String

    // "vote now" text, in selection voting phase
    let votePromptText: String

    // "time left" text, in selection voting phase
    let timerText: String

    // fill color for each column of the voting diagram, in selection voting phase
    let votingDiagramColors: [String]

    // voting results caption text ("you chose:"), in selection showResults phase
    let announcementText: String

    // "It's a tie!" text, in selection showResults phase
    let tieAnnouncementText: String

    // "operator will choose:" text, in selection showResults phase
    let tieOperatorChooseText: String

    // sound effect played in selection presentation phase - when presenting voting options
    let presentationSound: Sound?

    // sound effect played in selection voting phase - while users are voting in HTML clients
    let votingSound: Sound?

    // sound effect played when selection showResults phase -  voting results are displayed
    let resultsSound: Sound?
    
}


struct Sound: Codable {
    
    let filename: String

    let volume: Float? // decimal, from 0 to 1
}


