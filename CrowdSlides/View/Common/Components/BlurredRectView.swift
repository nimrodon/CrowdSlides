//
//  BlurredRectView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 26/01/2025.
//

import SwiftUI

struct BlurredRectView: View {
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .background(
                BlurEffect(material: .hudWindow, blendingMode: .withinWindow)
                    .opacity(0.7)
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    BlurredRectView()
}
