//
//  SlideshowSettingsDefaults.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 08/01/2025.
//

import Foundation

extension SlideshowSettings {
    
    public static let defaults = SlideshowSettings(
        isRTL: false,
        regularFontName: "",  // when blank, system font will be used
        boldFontName: "",     // when blank, system font will be used
        primaryColor: "#FFFFFF",
        backgroundColor: "#000000",
        panelBackgroundColor: "#000000",
        numOfUsersText: "Users Connected:",
        theEndText: "The End",
        selectionSettings: SlideshowSelectionSettings.defaults,
        startSlideId: nil
    )
   
}


extension SlideshowSelectionSettings {
    
    public static let defaults = SlideshowSelectionSettings(
        verticalSpaceFromBottom: 0,
        preparePromptText: "Prepare to vote:",
        orText: "or",
        votePromptText: "Vote now:",
        timerText: "Time left:",
        votingDiagramColors: ["#FF0000",    // red
                              "#0000FF",    // blue
                              "#FFFF00",    // yellow
                              "#00FF00"],   // green
        announcementText: "You chose:",
        tieAnnouncementText: "A tie!",
        tieOperatorChooseText: "The Operator will choose.",
        presentationSound: nil,
        votingSound: nil,
        resultsSound: nil
    )
    
}


extension ClientConfig {
    
    public static let defaults = ClientConfig(
        introTitleText: "An Interactive Story",
        joinText: "Thanks for joining!",
        waitForSelectionTexts: ["Please wait for the next decision."],
        voteSubmittedText: "Thanks you for your vote",
        endingText: "Thanks for participating!",
        isRTL: false)
}

