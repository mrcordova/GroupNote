//
//  FirebaseService.swift
//  GroupNote
//
//  Created by Noah Cordova on 3/18/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine

final class FirebaseService: ObservableObject {
    
    static let shared = FirebaseService()
    @Published var game: Game!
    
    init() {}
    
    
    
    func createOnlineGame()  {
        // save the game online
    }
    
    func startGame(with userId: String)   {
        // check if there is a game to join, if no, we create new game. If yes, we will join and start listening for any changes in the game
        FirebaseReference(.Game).whereField("player2Id", isEqualTo: "").whereField("player1Id", isNotEqualTo: userId).getDocuments { querySnapshot, error in
            if error != nil {
                print("Error starting error", error?.localizedDescription)
                //create new game
                self.createNewGame(with: userId)
                return
            }
            
            if let gameData = querySnapshot?.documents.first {
                self.game =  try? gameData.data(as: Game.self)
                self.game.player2Id = userId
                self.game.blockMoveForPlayerId = userId
                self.updateGame(self.game)
                self.listenForGameChanges()
            } else {
                self.createNewGame(with: userId)
            }
            
        }
        
    }
    
    func listenForGameChanges()  {
        
    }
    
    func updateGame(_ game: Game) {
        
    }
    
    func createNewGame(with userId: String) {
        // create new game object
    }
    
    func quitGame() {
        
    }
}
