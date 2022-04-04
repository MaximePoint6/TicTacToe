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
            Text(viewModel.squares[index].squareStatus == .cross ?
                    "X" : viewModel.squares[index].squareStatus == .circle ? "O" : " ")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
                .frame(width: 70, height: 70, alignment: .center)
                .background(Color.gray.opacity(0.2).cornerRadius(10))
                .padding(4)
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
