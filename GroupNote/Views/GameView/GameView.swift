//
//  GameView.swift
//  GroupNote
//
//  Created by Noah Cordova on 3/17/23.
//

import SwiftUI

struct GameView: View {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    var body: some View {
        GeometryReader { geomtry in
            VStack {
                Text("Waiting for the player")
                Button {
                    print("Quit the game")
                } label: {
                    GameButton(title: "Quit", backgroundColor: Color(.systemRed))
                }
                
                
                Text("Loading View")
                
                Spacer()
                
                VStack {
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(0..<9) { i in
                            ZStack {
                                Circle()
                                    .foregroundColor(.blue.opacity(0.7))
                                    .frame(width: geomtry.size.width / 3 - 15, height: geomtry.size.width / 3 - 15 )
                                Image(systemName: "applelogo")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                    
                            }
                        }
                    }
                }
            }
        }
       
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
