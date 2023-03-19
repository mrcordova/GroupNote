//
//  GameNotifications.swift
//  GroupNote
//
//  Created by Noah Cordova on 3/18/23.
//

import SwiftUI


enum GameState {
    case started
    case waitingForPlayer
    case finished
    
}


struct GameNotification {
    static let waitingForPlayer = "Waiting for player"
    static let gameHasStarted = "Game has started"
    static let gameFinished = "Player left the game"
}
