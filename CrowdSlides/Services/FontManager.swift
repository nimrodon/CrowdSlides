//
//  FontManager.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 24/01/2025.
//

import Foundation
import CoreText

class FontManager {
    
    
    public static func initSlideshowRegularFont(fontName: String) {
        if let installedFontName = installFont(fontName: fontName) {
            StyleGuide.AppFont.regularFontName = installedFontName
        }
    }

    
    public static func initSlideshowBoldFont(fontName: String) {
        if let installedFontName = installFont(fontName: fontName) {
            StyleGuide.AppFont.boldFontName = installedFontName
        }
    }

    
    private static func installFont(fontName: String) -> String? {

        guard !fontName.isEmpty else {
            return nil
        }
        
        guard let fontPath = LocalAssetsHelper.getFontPath(fontFilename: fontName) else {
            print("File not found: \(fontName)")
            return nil
        }

        guard let fontData = try? Data(contentsOf: fontPath) else {
            print("Failed to load font data from path: \(fontPath)")
            return nil
        }

        guard let provider = CGDataProvider(data: fontData as CFData) else {
            print("Failed to create data provider for font \(fontName)")
            return nil
        }

        guard let font = CGFont(provider) else {
            print("Failed to create CGFont \(fontName)")
            return nil
        }

        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            if let error = error?.takeUnretainedValue() {
                print("Error registering font \(fontName): \(error.localizedDescription)")
            }
            else {
                print("Unknown Error while registering font \(fontName)")
            }
            return nil
        }
        if let fontName = font.postScriptName as String? {
            return fontName
        }
        return nil
    }
}
