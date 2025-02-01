//
//  SharedDataModel.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 05/12/2024.
//

import Foundation

struct SharedData {

    // data needed for syncing the master app client and all html clients
    let state: SharedState

    // data used by html client. it is loaded into the DB on app init
    let clientConfig: ClientConfig

    // dictionary of users connected to the slideshow
    let users: [String: User]
}


struct SharedState {

    // type of currently displayed slide
    let currentSlideType: String

    // selection data. loaded into DB when selection slide is displayed.
    let currentSelection: SharedSelection

    // flag for html client to indicate when enable and disable voting
    let isVoting: Bool
}


struct SharedSelection : Encodable {

    // selection texts displayed by html client 
    let clientConfig: ClientSelectionConfig?

    // the amount of votes per option. incremented by HTML client according to user's vote
    let votes: [Int]
}


struct ClientSelectionConfig: Encodable {

    // description of the selection subject
    let message: String

    // options to vote
    let options: [String]
}


struct User {

    let didVote: String // unused
}
