//
//  ViewExtension.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 12/12/2024.
//

import SwiftUI

extension View {
    
    public func mainTitleTextStyle() -> some View {
        self.font(StyleGuide.AppFont.mainTitle)
            .foregroundColor(StyleGuide.Color.primary)
    }
    
    public func introInviteTextStyle() -> some View {
        self.font(StyleGuide.AppFont.introInvite)
            .foregroundColor(StyleGuide.Color.primary)
    }

    public func bodyTextStyle() -> some View {
        self.font(StyleGuide.AppFont.body)
            .foregroundColor(StyleGuide.Color.primary)
    }

    public func storyTextStyle() -> some View {
        self.font(StyleGuide.AppFont.story)
            .foregroundColor(StyleGuide.Color.primary)
    }
    
    public func selectionTextStyle() -> some View {
        self.font(StyleGuide.AppFont.selection)
            .foregroundColor(StyleGuide.Color.primary)
    }
    
    public func selectionPromptTextStyle() -> some View {
        self.font(StyleGuide.AppFont.selectionPrompt)
            .foregroundColor(StyleGuide.Color.primary)
    }
    
    public func optionTextStyle() -> some View {
        self.font(StyleGuide.AppFont.option)
            .foregroundColor(StyleGuide.Color.primary)
    }
    
    public func optionVotingTextStyle() -> some View {
        self.font(StyleGuide.AppFont.optionVoting)
            .foregroundColor(StyleGuide.Color.primary)
    }
    
    public func selectionTimerTextStyle() -> some View {
        self.font(StyleGuide.AppFont.selectionTimer)
            .foregroundColor(StyleGuide.Color.primary)
    }
    
    public func selectedOptionTextStyle() -> some View {
        self.font(StyleGuide.AppFont.selectedOption)
            .foregroundColor(StyleGuide.Color.primary)
    }
    
    public func theEndTextStyle() -> some View {
        self.font(StyleGuide.AppFont.theEnd)
            .foregroundColor(StyleGuide.Color.primary)
    }
}
