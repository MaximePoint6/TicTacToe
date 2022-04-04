//
//  SquareView.swift
//  TicTacToe
//
//  Created by Maxime Point on 04/04/2022.
//

import SwiftUI

struct SquareView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    var index: Int
    
    var body: some View {
        Button(action: {
            viewModel.playerAction(index: index)
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 70, height: 70, alignment: .center)
                    .padding(4)
                if viewModel.squares[index].squareStatus == .cross {
                    Text("X")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                } else if viewModel.squares[index].squareStatus == .circle {
                    Text("O")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.red)
                } else {
                    Text("")
                }
            }
        })
    }
}

struct SquareView_Previews: PreviewProvider {
    
    @StateObject static var gameViewModel = GameViewModel()
    static var index = 1
    
    static var previews: some View {
        SquareView(index: index)
            .environmentObject(gameViewModel)
    }
}
