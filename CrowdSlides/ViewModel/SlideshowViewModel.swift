//
//  SlideshowViewModel.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 06/12/2024.
//

import Foundation
import Combine

class SlideshowViewModel: ObservableObject {
    
    @Published private(set) var slides: [Slide] = []
    @Published private(set) var settings: SlideshowSettings = SlideshowSettings.defaults
    @Published private(set) var currentSlideIndex: Int = 0
    @Published private(set) var numOfUsers: Int = 0

    public weak var selectionInputDelegate: SelectionInputProtocol?

    private let inputManager: InputManager = InputManager()

    private var slideshowDataService: SlideshowDataService?
    private var dbService: SharedDBService?
    private var cancellables = Set<AnyCancellable>()
    private var slideIndexStack: [Int] = []
    private var slideIndexToJump: Int?
    

    public func configure(sharedDBService: SharedDBService,
                   slideshowDataService: SlideshowDataService)
    {
        self.dbService = sharedDBService
        slides = slideshowDataService.getSlides()
        settings = slideshowDataService.getSettings()
        
        initSlideshow()
        listenToVotes()
        listenToInput()
    }
    
    
    public func handleSelectionCompleted(selectedIndex: Int?) {
        if let selectedIndex = selectedIndex,
           case .selection(let selectionSlide) = slides[currentSlideIndex]
        {
            let selectedOption = selectionSlide.options[selectedIndex]
            slideIndexToJump = getIndexBySlideId(selectedOption.nextSlideId)
            advanceToNextSlide()
        }
        else {
            goBackToPreviousSlide()
        }
    }
    
    
    public func stopAllSounds() {
        SoundManager.shared.stopAllSounds()
    }
    
    
    public func playSlideSound() {
        if let sound = slides[currentSlideIndex].base.sound {
            SoundManager.shared.playSound(sound)
        }
    }
    
    
    // private methods
    
    private func handleAction(_ action: SlideAction) {
        if case .selection = slides[currentSlideIndex] {
            selectionInputDelegate?.handleAction(action)
            return
        }
            
        switch action {
            case .next:
                advanceToNextSlide()
            
            case .previous:
                goBackToPreviousSlide()
            default:
                break
        }
    }
    
    
    private func advanceToNextSlide() {
        if let nextSlideIndex = getNextSlideIndex() {
            slideIndexStack.append(currentSlideIndex)
            currentSlideIndex = nextSlideIndex
            slideIndexToJump = nil
            setCurrentSlideInfoInDB()
        }
    }

    
    private func goBackToPreviousSlide() {
        if !slideIndexStack.isEmpty {
            currentSlideIndex = slideIndexStack.removeLast()
            setCurrentSlideInfoInDB()
        }
    }
    
    
    private func getNextSlideIndex() -> Int? {
        
        let currentSlide = slides[currentSlideIndex]
        if case .ending = currentSlide {
            return nil
        }
        
        var nextSlideIndex: Int?
        if let slideIndex = slideIndexToJump {
            nextSlideIndex = slideIndex
        }
        else if let nextSlideId = currentSlide.base.nextSlideId {
            nextSlideIndex = getIndexBySlideId(nextSlideId)
        }
        else if currentSlideIndex + 1 <= slides.count - 1 {
            nextSlideIndex = currentSlideIndex + 1
        }
        return nextSlideIndex
    }
    
    
    private func setCurrentSlideInfoInDB() {
        let currentSlideType = slides[currentSlideIndex].typeString
        dbService?.setCurrentSlideType(currentSlideType)
    }
    

    private func initSlideshow() {
        if let startSlideId = settings.startSlideId {
            currentSlideIndex = getIndexBySlideId(startSlideId) ?? 0
        }
        else {
            currentSlideIndex = 0
        }
        setCurrentSlideInfoInDB()
    }

    
    private func listenToVotes() {
        dbService?.$numOfUsers
            .receive(on: DispatchQueue.main)
            .sink { [weak self] numOfUsers in
                self?.numOfUsers = numOfUsers
            }
            .store(in: &cancellables)
    }

    
    private func listenToInput() {
        inputManager.actionPublisher
            .sink { [weak self] action in
                self?.handleAction(action)
            }
            .store(in: &cancellables)

        inputManager.startListening()
    }
    
    private func getIndexBySlideId(_ slideId: String) -> Int? {
        return slides.firstIndex(where: { slide in
            slide.base.id == slideId
        })
    }
}
