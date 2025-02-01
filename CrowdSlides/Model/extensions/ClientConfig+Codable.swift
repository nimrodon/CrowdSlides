//
//  ClientConfig+Codable.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 28/01/2025.
//

import Foundation

extension ClientConfig {
    
    enum CodingKeys: String, CodingKey {
        case introTitleText
        case waitForSelectionTexts
        case voteSubmittedText
        case endingText
        case joinText
        case isRTL
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.introTitleText = try container.decodeIfPresent(String.self, forKey: .introTitleText) ?? ClientConfig.defaults.introTitleText
        self.waitForSelectionTexts = try container.decodeIfPresent([String].self, forKey: .waitForSelectionTexts) ?? ClientConfig.defaults.waitForSelectionTexts
        self.voteSubmittedText = try container.decodeIfPresent(String.self, forKey: .voteSubmittedText) ?? ClientConfig.defaults.voteSubmittedText
        self.endingText = try container.decodeIfPresent(String.self, forKey: .endingText) ?? ClientConfig.defaults.endingText
        self.joinText = try container.decodeIfPresent(String.self, forKey: .joinText) ?? ClientConfig.defaults.joinText
        self.isRTL = try container.decodeIfPresent(Bool.self, forKey: .isRTL) ?? ClientConfig.defaults.isRTL
    }
}
