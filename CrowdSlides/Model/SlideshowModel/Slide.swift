//
//  Slide.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 05/12/2024.
//

import Foundation


enum Slide: Codable, Equatable {

    case intro(IntroSlide)          // A slide containing a QR code for letting HTML client users join the slideshow. shows number of current users joined.
    case story(StorySlide)          // A simple slide with video, image or text
    case selection(SelectionSlide)  // Slide that lets the presents options for the users and lets them to vote
    case ending(EndingSlide)        // ending slide with thank you / farewell text

    
    static public func == (lhs: Slide, rhs: Slide) -> Bool {
        return lhs.base.id == rhs.base.id
    }

    public var typeString: String {
        switch self {
            case .intro: return SlideType.intro.rawValue
            case .story: return SlideType.story.rawValue
            case .selection: return SlideType.selection.rawValue
            case .ending: return SlideType.ending.rawValue
        }
    }

    private enum SlideType: String, Codable {
        case intro
        case story
        case selection
        case ending
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case type
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(SlideType.self, forKey: .type)

        switch type {
            case .intro:
                self = .intro(try IntroSlide(from: decoder))
            case .story:
                self = .story(try StorySlide(from: decoder))
            case .selection:
                self = .selection(try SelectionSlide(from: decoder))
            case .ending:
                self = .ending(try EndingSlide(from: decoder))
        }
    }

    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
            case .intro(let introSlide):
                try container.encode(SlideType.intro, forKey: .type)
                try introSlide.encode(to: encoder)
            case .story(let storySlide):
                try container.encode(SlideType.story, forKey: .type)
                try storySlide.encode(to: encoder)
            case .selection(let selectionSlide):
                try container.encode(SlideType.selection, forKey: .type)
                try selectionSlide.encode(to: encoder)
            case .ending(let endingSlide):
                try container.encode(SlideType.ending, forKey: .type)
                try endingSlide.encode(to: encoder)
        }
    }
}


extension Slide {
    var base: SlideBase {
        switch self {
            case .intro(let introSlide):
                return introSlide
            case .story(let storySlide):
                return storySlide
            case .selection(let selectionSlide):
                return selectionSlide
            case .ending(let endingSlide):
                return endingSlide
            }
    }
}

