//
//  AlertItem.swift
//  GroupNote
//
//  Created by Noah Cordova on 3/18/23.
//

import SwiftUI

struct AlertItem : Identifiable {
    var id = UUID()
    var isForQuit = false
    var title: Text
    var message: Text
    var buttonTitle: Text
    
}

struct AlertContext {
    static let youWin = AlertItem(title: Text("You win!"), message: Text("You are good at this game!"), buttonTitle: Text("Rematch"))
    static let youLost = AlertItem(title: Text("You lost!"), message: Text("Try Rematch!"), buttonTitle: Text("Rematch"))
    static let draw = AlertItem(title: Text("Draw!"), message: Text("That was a close game!"), buttonTitle: Text("Rematch"))
    static let quit = AlertItem( isForQuit: true, title: Text("Game Over"), message: Text("Other player left!"), buttonTitle: Text("Quit"))
}
