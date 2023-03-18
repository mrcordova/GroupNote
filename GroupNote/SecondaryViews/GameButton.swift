//
//  GameButton.swift
//  GroupNote
//
//  Created by Noah Cordova on 3/17/23.
//

import SwiftUI

struct GameButton: View {
    
    let title: String
    let backgroundColor: Color
    
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.semibold)
            .frame(width: 300, height: 50)
            .background(backgroundColor)
            .foregroundColor(Color.white)
            .cornerRadius(20)
    }
}

struct GameButton_Previews: PreviewProvider {
    static var previews: some View {
        GameButton(title: "Play", backgroundColor: Color.green)
    }
}
