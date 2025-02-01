//
//  LocalAssetsHelper.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 06/01/2025.
//

import AppKit

class LocalAssetsHelper {

    //-------------------------------------------------------------------------------------
    // note: moving the location of this file in the project will affect the calculation of
    // rootAssets path in debug mode. see "getFilePath" function.
    //-------------------------------------------------------------------------------------

    private static let assetsFolderName = "assets"
    
    private static let jsonSubfolderName = "json"
    private static let imagesSubfolderName = "images"
    private static let videosSubfolderName = "videos"
    private static let soundsSubfolderName = "sounds"
    private static let fontsSubfolderName = "fonts"

    
    public static func getJsonPath(jsonFilename: String) -> URL? {
        return getFilePath(filename: jsonFilename, categorySubfolder: jsonSubfolderName)
    }


    public static func getImagePath(imageFilename: String) -> URL? {
        return getFilePath(filename: imageFilename, categorySubfolder: imagesSubfolderName)
    }
    
    
    public static func getSoundPath(soundFilename: String) -> URL? {
        return getFilePath(filename: soundFilename, categorySubfolder: soundsSubfolderName)
    }

    
    public static func getVideoPath(videoFilename: String) -> URL? {
        return getFilePath(filename: videoFilename, categorySubfolder: videosSubfolderName)
    }

    public static func getFontPath(fontFilename: String) -> URL? {
        return getFilePath(filename: fontFilename, categorySubfolder: fontsSubfolderName)
    }

    
    public static func loadImage(named imageName: String) -> NSImage {
        
        if let imagePath = getImagePath(imageFilename: imageName),
           let nsImage = NSImage(contentsOfFile: imagePath.path)
        {
            return nsImage
        }
        else {
            return placeholderImage()
        }
    }

    
    private static func getFilePath(filename: String, categorySubfolder: String) -> URL? {

        // During development, the assets folder should be in the same folder as .xcodeproj file.
        // In production, the assets folder should be in the same folder as the .app file.
        
        #if DEBUG

        let projectFilePath = URL(fileURLWithPath: #file)
        let rootAssetsPath = projectFilePath.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
        
        #else

        let rootAssetsPath = Bundle.main.bundleURL.deletingLastPathComponent()

        #endif

        let folderPath = rootAssetsPath.appendingPathComponent("\(assetsFolderName)/\(categorySubfolder)")
        let filePath = folderPath.appendingPathComponent(filename)

        if FileManager.default.fileExists(atPath: filePath.path) {
            return filePath
        }
        else {
            return nil
        }
    }
    
    
    private static func placeholderImage() -> NSImage {
        let placeholder = NSImage(size: NSSize(width: 100, height: 100))
        placeholder.lockFocus()
        NSColor.lightGray.setFill()
        NSRect(x: 0, y: 0, width: 100, height: 100).fill()
        placeholder.unlockFocus()
        return placeholder
    }
}
