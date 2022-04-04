//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Maxime Point on 04/04/2022.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    
    @StateObject var gameViewModel = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(gameViewModel)
        }
    }
}
