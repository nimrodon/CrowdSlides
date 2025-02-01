//
//  Color.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 25/01/2025.
//

import SwiftUI

extension StyleGuide {
    
    struct Color {
        
        static private(set) var primary = SwiftUI.Color.clear
        static private(set) var background = SwiftUI.Color.clear
        static private(set) var panelBackground = SwiftUI.Color.clear

        static func setPrimaryColor(hex: String) {
            primary = ColorHelper.colorFromHex(hex)
        }

        static func setBackgroundColor(hex: String) {
            background = ColorHelper.colorFromHex(hex)
        }

        static func setPanelBackgroundColor(hex: String) {
            panelBackground = ColorHelper.colorFromHex(hex)
        }

    }
}

