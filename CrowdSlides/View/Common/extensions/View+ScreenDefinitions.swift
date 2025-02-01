//
//  View+ScreenDefinitions.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 30/01/2025.
//


import SwiftUI

extension View {
    
    public func screenDefinitions() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(StyleGuide.Color.background.edgesIgnoringSafeArea(.all))
    }
    
}
