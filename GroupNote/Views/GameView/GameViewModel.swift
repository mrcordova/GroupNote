//
//  GameViewModel.swift
//  GroupNote
//
//  Created by Noah Cordova on 3/18/23.
//

import SwiftUI
import Combine

final class GameViewModel: ObservableObject {
    
    @AppStorage("user") private var userData: Data?
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
   
    @Published var game: Game? {
        didSet {
            //check the game status
            
        }
    }
    @Published var currentUser: User!
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let winPatterns: Set<Set<Int>> = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,1,2], [0, 4, 8], [2,4,6] ]
    init() {
        retriveUser()
        if currentUser == nil {
            saveUser()
        }
    }
    
    func getTheGame() {
        FirebaseService.shared.startGame(with: currentUser.id)
        FirebaseService.shared.$game.assign(to: \.game, on: self)
            .store(in: &cancellables)
        
    }
    
    func processPlayerMove(for position: Int) {
        guard game != nil else { return }

        if isSquareOccupied(in: game!.moves, forIndex: position) { return }


        game?.moves[position] = Move(isPlayer1: isPlayerOne(), boardIndex: position)
        game?.blockMoveForPlayerId = currentUser.id
        FirebaseService.shared.updateGame(game!)

        if checkForWinCondition(for: true, in: game!.moves) {
        
            game?.winningPlayerId = currentUser.id
            FirebaseService.shared.updateGame(game!)
            return
        }

        if checkForDraw(in: game!.moves) {
            game?.winningPlayerId = "0"
            FirebaseService.shared.updateGame(game!)
            return
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        
        return moves.contains(where: { $0?.boardIndex == index })
    }
    
    func checkForWinCondition(for player1: Bool, in moves: [Move?] ) -> Bool {
        // remove all nils
        let playerMoves = moves.compactMap{ $0 }.filter{ $0.isPlayer1 == player1 }
        let playerPositions = Set(playerMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap{ $0 }.count == 9
    }
    
    func quitGame()  {
        FirebaseService.shared.quitGame()
    }
    
    func checkForGameBoardStatus() -> Bool {
        return game != nil ? game!.blockMoveForPlayerId == currentUser.id : false
    }
    func isPlayerOne() -> Bool {
        return game != nil ? game?.player1Id == currentUser.id : false
    }
    
    func checkIfGameIsOver() {
        guard game != nil else { return }
        
        if game!.winningPlayerId == "0" {
            //draw
        } else if game!.winningPlayerId != "" {
            if game!.winningPlayerId == currentUser.id {
                // we won
            } else {
                // we lost
            }
        }
    }
    
    func saveUser() {
        currentUser = User()
        do {
            print("encoding user")
            let data = try JSONEncoder().encode(currentUser)
            userData = data

        } catch {
            print("Could not save user object")
        }
    }
    func retriveUser()  {
        guard let userData = userData else { return }
        
        do {
            print("decoding user")
            currentUser = try JSONDecoder().decode(User.self, from: userData)

        } catch {
            print("no user saved")
        }
    }
}

