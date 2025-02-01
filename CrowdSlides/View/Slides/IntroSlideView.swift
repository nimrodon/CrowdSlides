//
//  IntroSlideView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 08/12/2024.
//

import SwiftUI

struct IntroSlideView: View {
    
    let slide: IntroSlide
    let settings: SlideshowSettings
    let numOfUsers: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let imageFileName = slide.backgroundImage {
                    Image(nsImage: LocalAssetsHelper.loadImage(named: imageFileName))                     .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
                VStack {
                    Text(slide.titleText)
                        .mainTitleTextStyle()
                        .padding(.bottom, geometry.size.height * 0.02)
                    
                    IntegerWithCaptionView(caption: settings.numOfUsersText,
                                           value: numOfUsers)
                        .storyTextStyle()
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.13)
                    
                    Image(nsImage: LocalAssetsHelper.loadImage(named: slide.QRCodeImage))
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: geometry.size.width * 0.4,
                            height: geometry.size.height * 0.4
                        )
                    
                    Text(slide.inviteText)
                        .introInviteTextStyle()
                        .padding(.top, geometry.size.height * 0.05)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding()
            }
        }
    }
}

#Preview {
    IntroSlideView(slide: IntroSlide(id: "intro", nextSlideId: nil, backgroundImage: nil, sound: nil, stopAllSounds: nil, titleText: "Men's gift shop - an Interactive sketch", inviteText: "Scan to join", QRCodeImage: "qr_code" ), settings: SlideshowSettings.defaults, numOfUsers: 10)
}
