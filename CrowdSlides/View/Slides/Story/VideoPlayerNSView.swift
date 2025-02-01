//
//  VideoPlayerNSView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 20/12/2024.
//

import AVKit

class VideoPlayerNSView: NSView {
    
    private let playerLayer: AVPlayerLayer

    init(playerLayer: AVPlayerLayer) {
        self.playerLayer = playerLayer
        super.init(frame: .zero)
        self.wantsLayer = true
        self.layer = CALayer()
        self.layer?.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override public func layout() {
        super.layout()
        if bounds != .zero {
            playerLayer.frame = bounds
        }
    }
}

