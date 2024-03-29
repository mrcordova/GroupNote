//
//  GameSquareView.swift
//  GroupNote
//
//  Created by Noah Cordova on 3/17/23.
//

import SwiftUI

struct GameSquareView: View {
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .foregroundColor(.blue.opacity(0.7))
            .frame(width: proxy.size.width / 3 - 15, height: proxy.size.width / 3 - 15 )
    }
}

//struct GameSquareView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameSquareView()
//    }
//}
