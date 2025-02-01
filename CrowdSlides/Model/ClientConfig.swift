//
//  ClientConfig.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 08/12/2024.
//

import Foundation

struct ClientConfig : Codable {

    // all properties here are used in the html client:
    
    // slideshow title, used in intro slide
    let introTitleText: String

    // "you have succsefully joined" message
    let joinText: String

    // list of waiting messages to display while waiting for the next voting. chosed randomly by client
    let waitForSelectionTexts: [String]

    // text for acknowledgment of user's vote, used in selection slide
    let voteSubmittedText: String

    // thank you / farewell message, used in selection slide
    let endingText: String

    //  assigned programatically from slideshow settings
    var isRTL: Bool
}
