//
//  GameOverView.swift
//  TicTacToe
//
//  Created by Maxime Point on 04/04/2022.
//

import SwiftUI

struct GameOverView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Text("Congratulations \(viewModel.currentPlayer) 🎉")
                .font(.title)
                .font(.system(size: 20))
            Text("+1 point for you !")
            Button(action: {
                viewModel.resetSquares()
                viewModel.nextPlayer()
                dismiss()
            }, label: {
                Text("Return to play")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    .background(.red)
                    .clipShape(Capsule())
            }).padding()
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    
    @StateObject static var gameViewModel = GameViewModel()
    
    static var previews: some View {
        GameOverView()
            .environmentObject(gameViewModel)
    }
}
