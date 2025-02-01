//
//  DBPaths.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 09/01/2025.
//

enum DBPaths {
    
    // Root base path
    static let base = "sharedData"
    
    // High-level branches
    static let state = "\(base)/state"
    static let users = "\(base)/users"
    static let clientConfig = "\(base)/clientConfig"
    
    // State subpaths
    static let currentSelection = "\(state)/currentSelection"
    static let currentSlideType = "\(state)/currentSlideType"
    static let isVoting = "\(state)/isVoting"
    
    // Current selection subpath
    static let votes = "\(currentSelection)/votes"
}

