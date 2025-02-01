//
//  Components.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 26/12/2024.
//

import SwiftUI

struct IntegerWithCaptionView: View {
    
    let caption: String
    let value: Int
    
    
    var body: some View {
        HStack {
            Text(caption)
                .frame(alignment: .trailing)
            
            Spacer().frame(width: 16)
            
            Text("\(value)")
                .frame(width: 70, alignment: .trailing)
        }
    }
}

