//
//  VotingHelper.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 09/01/2025.
//

import Foundation
import Combine

class VotingHelper: ObservableObject {

    private var votingTimer: CountdownTimer?
    private var dbService: SharedDBService
    private var votingDuration: Int
    private var votingTimerUpdateHandler: ((Int) -> Void)
    private var votingCompleteHandler: (() -> Void)
    private var votesUpdateHandler: (([Int]) -> Void)
    private var votesBinding: AnyCancellable?

    
    init(dbService: SharedDBService,
         votingDuration: Int,
         votingTimerUpdateHandler: @escaping ((Int) -> Void),
         votingCompleteHandler: @escaping (() -> Void),
         votesUpdateHandler: @escaping (([Int]) -> Void))
    {
        self.dbService = dbService
        self.votingDuration = votingDuration
        self.votingTimerUpdateHandler = votingTimerUpdateHandler
        self.votingCompleteHandler = votingCompleteHandler
        self.votesUpdateHandler = votesUpdateHandler
        initCountdownTimer()
    }
    
    
    public func startVoting() {
        startListeningToVotes()
        dbService.setIsVoting(true)
        votingTimer?.start()
    }

    
    public func stopVoting() {
        stopListeningToVotes()
        votingTimer?.stop()
        dbService.setIsVoting(false)
    }

    
    public func determineSelectedOption(votes: [Int]) -> Int{
        if let maxVotes = votes.max() {
            let indices = votes.enumerated().compactMap { index, value in
                value == maxVotes ? index : nil
            }
            if indices.count == 1 {
                return indices[0]
            }
        }
        return -1
    }
    
    
    // private methods
    
    private func initCountdownTimer() {
        votingTimer = CountdownTimer(duration: votingDuration)
        votingTimer?.onUpdate = { [weak self] remainingTime in
            self?.votingTimerUpdateHandler(remainingTime)
        }
        votingTimer?.onComplete = { [weak self] in
            self?.votingCompleteHandler()
        }
    }


    private func startListeningToVotes() {
        votesBinding = dbService.$votes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newVotes in
                self?.votesUpdateHandler(newVotes)
            }
    }

    
    private func stopListeningToVotes() {
        votesBinding?.cancel()
        votesBinding = nil
    }

}


