//
//  GameView.swift
//  TicTacToe
//
//  Created by Maxime Point on 04/04/2022.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("03:00")
                    .font(.title)
                    .padding()
                HStack {
                    if viewModel.currentPlayer == "Player 1" {
                        Image(systemName: "chevron.forward.circle.fill")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "chevron.forward.circle.fill")
                            .foregroundColor(.gray).opacity(0.20)
                    }
                    Text(viewModel.player1.score < 2 ?
                         "Player 1 : \(viewModel.player1.score) point" : "Player 1 : \(viewModel.player1.score) points")
                }
                HStack {
                    if viewModel.currentPlayer == "Player 2" {
                        Image(systemName: "chevron.forward.circle.fill")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "chevron.forward.circle.fill")
                            .foregroundColor(.gray).opacity(0.20)
                    }
                    Text(viewModel.player2.score < 2 ?
                         "Player 2 : \(viewModel.player2.score) point" : "Player 2 : \(viewModel.player2.score) points")
                }
                Button(action: {
                    viewModel.resetScores()
                }, label: {
                    Text("Reset scores")
                }).padding(.bottom, 20)
                    .padding(.top, 5)
                ForEach(0 ..< viewModel.squares.count / 3) { row in
                    HStack {
                        ForEach(0 ..< 3) { column in
                            let index = row * 3 + column
                            SquareView(index: index)
                        }
                    }
                }
            }.sheet(isPresented: $viewModel.gameOver) {
                GameOverView()
            }
            .navigationTitle("TicTacToe")
        }
    }
}

struct GameView_Previews: PreviewProvider {
    
    @StateObject static var gameViewModel = GameViewModel()
    
    static var previews: some View {
        GameView()
            .previewDevice("iPhone 13")
            .environmentObject(gameViewModel)
    }
}
