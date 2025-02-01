//
//  SlideBackgroundImage.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 26/01/2025.
//

import SwiftUI

struct SlideBackgroundImageView: View {
    
    let fileName: String
    
    var body: some View {
        Image(nsImage: LocalAssetsHelper.loadImage(named: fileName))
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .ignoresSafeArea()

    }
}

#Preview {
    SlideBackgroundImageView(fileName: "bed_ants.webp")
}
