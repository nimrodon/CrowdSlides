//
//  KeyboardManager.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 07/12/2024.
//


import AppKit
import Combine

class InputManager: ObservableObject {
    
    private let actionSubject = PassthroughSubject<SlideAction, Never>()
    private var eventMonitor: Any?
    
    public var actionPublisher: AnyPublisher<SlideAction, Never> {
        actionSubject.eraseToAnyPublisher()
    }

    
    public func startListening() {
        eventMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            self.handleKeyPress(event)
            return nil
        }
    }

    
    public func stopListening() {
        if let monitor = eventMonitor {
            NSEvent.removeMonitor(monitor)
            eventMonitor = nil
        }
    }
    

    private func handleKeyPress(_ event: NSEvent) {
        switch event.keyCode {
        case 123: // Left arrow
            actionSubject.send(.previous)
        case 124, // Right arrow
             49: // Spacebar
            actionSubject.send(.next)
        case 18...21: // numbers 1..4
            let chosenOptionIndex = Int(event.keyCode) - 18
            actionSubject.send(.chooseOption(chosenOptionIndex))
        default:
            break
        }
    }

}

