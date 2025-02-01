//
//  SlideshowDataService.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 05/12/2024.
//

import Foundation

class SlideshowDataService: ObservableObject {
    
    private let slideshowJsonFilename: String = "slideshow.json"
    private let clientConfigJsonFilename: String = "client_config.json"

    private var slideshow: Slideshow?
    private var clientConfig: ClientConfig?
    
    
    init() {
        slideshow = loadJsonFromFile(slideshowJsonFilename, as: Slideshow.self)
        clientConfig = loadJsonFromFile(clientConfigJsonFilename, as: ClientConfig.self)

        precondition(slideshow != nil, "Failed to load slideshow data!")
        precondition(clientConfig != nil, "Failed to load client config data!")
        
        clientConfig!.isRTL = slideshow!.settings.isRTL
    }

    
    public func getSlides() -> [Slide] {
        return slideshow?.slides ?? []
    }

    
    public func getSettings() -> SlideshowSettings {
        return slideshow?.settings ?? SlideshowSettings.defaults
    }
    
    
    public func getClientConfig() -> ClientConfig {
        return clientConfig ?? ClientConfig.defaults
    }
    
    
    private func loadJsonFromFile<T: Decodable>(_ filename: String, as type: T.Type) -> T? {
        guard let jsonFilePath = LocalAssetsHelper.getJsonPath(jsonFilename: filename) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: jsonFilePath)
            let decodedData = try JSONDecoder().decode(type, from: data)
            return decodedData
        } catch {
            let error = "Error loading \(filename): \(error.localizedDescription)"
            print(error)
            return nil
        }
    }
}

