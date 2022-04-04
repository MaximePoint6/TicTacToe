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
                Text("\(viewModel.minutes) : \(viewModel.seconds)")
                    .onReceive(viewModel.timer) { _ in
                        if viewModel.time > 1 {
                            viewModel.time -= 1
                        } else if viewModel.time == 1 {
                            viewModel.time -= 1
                            viewModel.timeElapsed.toggle()
                        } else {
                        }
                    }
                    .font(.system(size: 50))
                    .padding(40)
                HStack {
                    if viewModel.currentPlayer == "Player 1" {
                        Image(systemName: "chevron.forward.circle.fill")
                            .foregroundColor(.red)
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
                }).padding(.bottom, 40)
                    .padding(.top, 3)
                ForEach(0 ..< viewModel.squares.count / 3) { row in
                    HStack {
                        ForEach(0 ..< 3) { column in
                            let index = row * 3 + column
                            SquareView(index: index)
                        }
                    }
                }
                Spacer()
            }.fullScreenCover(isPresented: $viewModel.gameOver) {
                GameOverView()
            }
            .alert(viewModel.alertText, isPresented: $viewModel.timeElapsed) {
                Button("Ok", role: .cancel) {
                    viewModel.resetTime()
                    viewModel.resetScores()
                }
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
