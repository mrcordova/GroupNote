//
//  GameView.swift
//  GroupNote
//
//  Created by Noah Cordova on 3/17/23.
//

import SwiftUI

struct GameView: View {
    

    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        GeometryReader { geomtry in
            VStack {
                Text(viewModel.gameNotification)
                Button {
                    dismiss()
                    viewModel.quitGame()
                } label: {
                    GameButton(title: "Quit", backgroundColor: Color(.systemRed))
                }
                
                
                if viewModel.game?.player2Id == "" {
                    LoadingView()
                }
                
                Spacer()
                
                VStack {
                    LazyVGrid(columns: viewModel.columns, spacing: 5) {
                        ForEach(0..<9) { i in
                            ZStack {
                        
                                GameSquareView(proxy: geomtry)
                                PlayerIndicatorView(systemImageName: viewModel.game?.moves[i]?.indicator ?? "applelogo")
                                    
                            }
                            .onTapGesture {
                                viewModel.processPlayerMove(for: i)
                            }
                        }
                    }
                }
                .disabled(viewModel.checkForGameBoardStatus())
                .padding()
                .alert(item: $viewModel.alertItem) { alertItem in
                    alertItem.isForQuit ? Alert(title: alertItem.title, message: alertItem.message, dismissButton: .destructive(alertItem.buttonTitle, action: {
                        dismiss()
                        viewModel.quitGame()
                    })
                                                )
                    :
                    Alert(title: alertItem.title, message: alertItem.message, primaryButton: .default(alertItem.buttonTitle, action: {
                        // reset game
                        viewModel.resetGame()
                        
                    }), secondaryButton: .destructive(Text("Quit"), action: {
                        dismiss()
                        viewModel.quitGame()
                    }))
                    
                }
                
            }
        }
        .onAppear {
            viewModel.getTheGame()
        }
       
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
