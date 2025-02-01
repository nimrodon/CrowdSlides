//
//  SlidehowSelectionSettings+Codable.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 28/01/2025.
//

import Foundation

extension SlideshowSelectionSettings {
    
    enum CodingKeys: String, CodingKey {
        case verticalSpaceFromBottom
        case preparePromptText
        case orText
        case votePromptText
        case timerText
        case votingDiagramColors
        case announcementText
        case tieAnnouncementText
        case tieOperatorChooseText
        case presentationSound
        case votingSound
        case resultsSound
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.verticalSpaceFromBottom = try container.decodeIfPresent(Int.self, forKey: .verticalSpaceFromBottom) ?? SlideshowSelectionSettings.defaults.verticalSpaceFromBottom
        self.preparePromptText = try container.decodeIfPresent(String.self, forKey: .preparePromptText) ?? SlideshowSelectionSettings.defaults.preparePromptText
        self.orText = try container.decodeIfPresent(String.self, forKey: .orText) ?? SlideshowSelectionSettings.defaults.orText
        self.votePromptText = try container.decodeIfPresent(String.self, forKey: .votePromptText) ?? SlideshowSelectionSettings.defaults.votePromptText
        self.timerText = try container.decodeIfPresent(String.self, forKey: .timerText) ?? SlideshowSelectionSettings.defaults.timerText
        self.votingDiagramColors = try container.decodeIfPresent([String].self, forKey: .votingDiagramColors) ?? SlideshowSelectionSettings.defaults.votingDiagramColors
        self.announcementText = try container.decodeIfPresent(String.self, forKey: .announcementText) ?? SlideshowSelectionSettings.defaults.announcementText
        self.tieAnnouncementText = try container.decodeIfPresent(String.self, forKey: .tieAnnouncementText) ?? SlideshowSelectionSettings.defaults.tieAnnouncementText
        self.tieOperatorChooseText = try container.decodeIfPresent(String.self, forKey: .tieOperatorChooseText) ?? SlideshowSelectionSettings.defaults.tieOperatorChooseText
        self.presentationSound = try container.decodeIfPresent(Sound.self, forKey: .presentationSound) ?? SlideshowSelectionSettings.defaults.presentationSound
        self.votingSound = try container.decodeIfPresent(Sound.self, forKey: .votingSound) ?? SlideshowSelectionSettings.defaults.votingSound
        self.resultsSound = try container.decodeIfPresent(Sound.self, forKey: .resultsSound) ?? SlideshowSelectionSettings.defaults.resultsSound
    }
}
