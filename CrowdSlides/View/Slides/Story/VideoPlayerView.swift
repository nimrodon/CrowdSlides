//
//  VideoPlayerView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 20/12/2024.
//

import AppKit
import AVKit
import SwiftUI

struct VideoPlayerView: NSViewRepresentable {
    
    typealias NSViewType = NSView
    
    let videoFile: String
    
    public func makeNSView(context: Context) -> NSView {
        
        guard let videoFilePath = LocalAssetsHelper.getVideoPath(videoFilename: videoFile) else {
            return NSView()
        }
        let player = AVPlayer(url: videoFilePath)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill

        let videoView = VideoPlayerNSView(playerLayer: playerLayer)
        player.play()
        return videoView
    }
        
    public func updateNSView(_ nsView: NSView, context: Context) {
    }
    
}

