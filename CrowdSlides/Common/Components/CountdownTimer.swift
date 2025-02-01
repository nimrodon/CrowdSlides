//
//  CountdownTimer.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 09/12/2024.
//

import Foundation
import Combine

class CountdownTimer {
    
    public var onUpdate: ((Int) -> Void)?
    public var onComplete: (() -> Void)?

    private var duration: Int
    private var endTime: Date?
    private var timer: AnyCancellable?
    private let interval: TimeInterval = 1.0
    
    
    init(duration: Int) {
        self.duration = duration
    }

    
    public func start() {
        stop()
        endTime = Date().addingTimeInterval(TimeInterval(duration))
        notifyRemainingTime()

        timer = Timer.publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.notifyRemainingTime()
            }
    }

    
    public func stop() {
        timer?.cancel()
        timer = nil
    }

    
    private func notifyRemainingTime() {
        guard let endTime = endTime else {
            return
        }
        let remaining = Int(endTime.timeIntervalSinceNow)
        if remaining > 0 {
            onUpdate?(remaining)
        }
        else {
            onUpdate?(0)
            onComplete?()
            stop()
        }
    }
}
