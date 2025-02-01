//
//  SelectionSlideViewModel.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 08/12/2024.
//

import Foundation
import Combine

class SelectionSlideViewModel: ObservableObject, SelectionInputProtocol {
    
    @Published private(set) var slide: SelectionSlide?
    @Published private(set) var currentPhase: SelectionPhase = .presentation
    @Published private(set) var numOfUsers: Int = 0
    @Published private(set) var votes: [Int] = []
    @Published private(set) var votingTimeLeft: Int = 0
    @Published private(set) var selectedOptionIndex: Int = -1

    public var settings: SlideshowSelectionSettings = SlideshowSelectionSettings.defaults

    private var dbService: SharedDBService?
    private var votingHelper: VotingHelper?
    private var selectionSoundHelper: SelectionSoundHelper?
    private var selectionCompletedHandler: ((Int?) -> Void)?

    
    public func configure(sharedDBService: SharedDBService,
                   slide: SelectionSlide,
                   settings: SlideshowSelectionSettings,
                   selectionCompletedHandler: @escaping (Int?) -> Void )
    {
        self.dbService = sharedDBService
        self.slide = slide
        self.settings = settings
        self.selectionCompletedHandler = selectionCompletedHandler
        

        selectionSoundHelper = SelectionSoundHelper(settings: settings)
        votingHelper = VotingHelper(dbService: sharedDBService,
                                    votingDuration: slide.selectionDuration,
                                    votingTimerUpdateHandler: handleVotingTimerUpdate,
                                    votingCompleteHandler: advanceToNextPhase,
                                    votesUpdateHandler: handleVotesUpdate)
        initDB()
        initPresentationPhase()
    }
    
    
    public func handleAction(_ action: SlideAction) {
        switch action {
            case .next:
                advanceToNextPhase()
            case .previous:
                goBackToPreviousPhase()
            case .chooseOption(let optionIndex):
                handleForcedVote(index: optionIndex)
        }
    }

    
    public func handleSound() {
        selectionSoundHelper?.handleSound(currentPhase: currentPhase)
    }

    
    private func handleVotingTimerUpdate(timeLeft: Int) {
        votingTimeLeft = timeLeft
    }
    
    
    private func handleVotesUpdate(votes: [Int]) {
        self.votes = votes
    }

    
    // private methods

    private func initDB() {
        if let slide = slide {
            let sharedSelection = prepareSharedSelection(from: slide)
            dbService?.setCurrentSelection(sharedSelection)
        }
    }

    
    // creating shared data needed for selection phase based on the selection slide's data.
    private func prepareSharedSelection(from selectionSlide: SelectionSlide) -> SharedSelection {
        let clientSelectionOptions: [String] = selectionSlide.options.map { $0.clientText ?? $0.text }
        let clientSelectionConfig = ClientSelectionConfig(message: selectionSlide.clientText ?? selectionSlide.text , options: clientSelectionOptions)
        let sharedSelection = SharedSelection(clientConfig: clientSelectionConfig, votes: [])
        return sharedSelection
    }

    
    private func advanceToNextPhase() {
        switch currentPhase {
            
            case .presentation:
                initVotingPhase()

            case .voting:
                initShowResultsPhase()
            
            case .showResults:
                if selectedOptionIndex != -1 {
                    exitSelection(selectedOptionIndex: selectedOptionIndex)
                }
       }
    }


    private func goBackToPreviousPhase() {
        
        switch currentPhase {

            case .presentation:
                exitSelection(selectedOptionIndex: nil)

            default:
                initPresentationPhase()
        }
    }
    
    
    private func initVotingPhase() {
        self.numOfUsers = dbService?.numOfUsers ?? 0
        initVotes()
        votingHelper?.startVoting()
        currentPhase = .voting
    }

    
    private func initShowResultsPhase(ignoreCrowdSelection: Bool = false) {
        votingHelper?.stopVoting()
        if !ignoreCrowdSelection {
            selectedOptionIndex = votingHelper?.determineSelectedOption(votes: votes) ?? -1
        }
        currentPhase = .showResults
    }

    
    private func initPresentationPhase() {
        votingHelper?.stopVoting()
        initVotes()
        currentPhase = .presentation
    }
    
    
    private func initVotes() {
        votes = Array(repeating: 0, count: slide?.options.count ?? 0)
        dbService?.setVotes(votes)
        selectedOptionIndex = -1
    }
    
    
    private func handleForcedVote(index: Int) {
        guard index <= votes.count - 1 else {
            return
        }
        if currentPhase == .voting || (currentPhase == .showResults && selectedOptionIndex == -1) {
            selectedOptionIndex = index
            initShowResultsPhase(ignoreCrowdSelection: true)
        }
    }

    
    private func exitSelection(selectedOptionIndex: Int?) {
        selectionCompletedHandler?(selectedOptionIndex)
    }
    
}
