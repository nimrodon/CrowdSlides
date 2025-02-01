//
//  Encodable+Extensions.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 07/12/2024.
//

import Foundation

extension Encodable {
    
    public func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else
        {
            return nil
        }
        return dictionary
    }
    
}
