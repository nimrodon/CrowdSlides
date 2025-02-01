//
//  ColorHelper.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 27/01/2025.
//

import SwiftUI

class ColorHelper {
    
    public static func colorFromHex(_ hex: String) -> SwiftUI.Color {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        let scanner = Scanner(string: hexSanitized)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0

        return SwiftUI.Color(red: red, green: green, blue: blue)
    }
    
    public static func colorsFromHexes(_ hexes: [String]) -> [SwiftUI.Color] {
        return hexes.map { hex in
            colorFromHex(hex)
        }
    }

}
