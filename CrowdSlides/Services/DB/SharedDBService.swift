//
//  SharedDBService.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 06/12/2024.
//

import Foundation
import Firebase
import FirebaseDatabase

class SharedDBService: ObservableObject {
    
    @Published private(set) var votes: [Int] = []
    @Published private(set) var numOfUsers: Int = 0

    private let db: DatabaseReference
    
    
    init() {
        FirebaseApp.configure()
        db = Database.database().reference()
        listenToDBChanges()
    }
    
    
    public func setClientConfig(_ clientConfig: ClientConfig) {
        guard let clientConfigDict = clientConfig.toDictionary() else {
            print("Failed to convert ClientConfig to dictionary")
            return
        }
        setValue(clientConfigDict, at: DBPaths.clientConfig)
    }

    
    public func setCurrentSelection(_ selection: SharedSelection) {
        guard let selectionDict = selection.toDictionary() else {
            print("Failed to convert SharedSelection to dictionary")
            return
        }
        setValue(selectionDict, at: DBPaths.currentSelection)
    }

    
    public func setVotes(_ votes: [Int]) {
        setValue(votes, at: DBPaths.votes)
    }

    
    public func setCurrentSlideType(_ slideType: String) {
        setValue(slideType, at: DBPaths.currentSlideType)
    }

    
    public func setIsVoting(_ isVoting: Bool) {
        setValue(isVoting, at: DBPaths.isVoting)
    }

    
    public func clearUsers() {
        removeValue(at: DBPaths.users) { error in
            if error == nil {
                self.numOfUsers = 0
            }
        }
    }
   
    
    // private methods
    
    private func listenToDBChanges() {
        listenToUserVotes()
        listenToUserJoin()
    }
    
    
    private func listenToUserVotes()  {
        db.child(DBPaths.votes).observe(.value) { snapshot in
            self.votes = snapshot.value as? [Int] ?? self.votes
        }
    }
    
    
    private func listenToUserJoin() {
        let usersRef = db.child(DBPaths.users)
        usersRef.observe(.childAdded) { snapshot in
            self.numOfUsers += 1
        }
    }

    
    private func updateNumOfUsers() {
        let usersRef = db.child(DBPaths.users)
        usersRef.observeSingleEvent(of: .value) { snapshot in
            if let value = snapshot.value as? [String: Any] {
                self.numOfUsers = value.keys.count
            }
            else {
                print ("error in updateNumOfUsers")
            }
        }
    }

    
    private func setValue<T>(_ value: T, at path: String, completion: @escaping (Error?) -> Void = { _ in }) {
        db.child(path).setValue(value) { error, _ in
            if let error = error {
                print("Error setting value at \(path): \(error.localizedDescription)")
            }
            completion(error)
        }
    }

    
    private func removeValue(at path: String, completion: @escaping (Error?) -> Void = { _ in }) {
        db.child(path).removeValue { error, _ in
            if let error = error {
                print("Error removing value at \(path): \(error.localizedDescription)")
            }
            completion(error)
        }
    }
}
