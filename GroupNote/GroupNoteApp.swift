//
//  GroupNoteApp.swift
//  GroupNote
//
//  Created by Noah Cordova on 3/17/23.
//

import SwiftUI
import Firebase

@main
struct GroupNoteApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
