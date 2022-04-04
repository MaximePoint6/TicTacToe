//
//  GameOverView.swift
//  TicTacToe
//
//  Created by Maxime Point on 04/04/2022.
//

import SwiftUI

struct GameOverView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            viewModel.resetGame()
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Congratulations \(viewModel.currentPlayer) 🎉 +1 point for you, we start again ?")
                .font(.system(size: 12))
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .background(.gray)
                .clipShape(Capsule())
        })
    }
}

struct GameOverView_Previews: PreviewProvider {
    
    @StateObject static var gameViewModel = GameViewModel()
    
    static var previews: some View {
        GameOverView()
            .environmentObject(gameViewModel)
    }
}
