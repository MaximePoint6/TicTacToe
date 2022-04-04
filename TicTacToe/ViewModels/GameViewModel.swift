//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Maxime Point on 04/04/2022.
//

import Foundation

class GameViewModel : ObservableObject {
    @Published var squares = [Square]()
    @Published var player1 = User(name: "Player 1", score: 0)
    @Published var player2 = User(name: "Player 2", score: 0)
    @Published var currentPlayer: String = "Player 1"
    @Published var gameOver = false
    @Published var timeElapsed = false
    
    @Published var time = 180
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(){
        for _ in 0...8 {
            squares.append(Square(status: .empty))
        }
    }
    
    
    var minutes: String {
        if (self.time/60) < 10 {
            return "0\(self.time/60)"
        } else {
            return "\(self.time/60)"
        }
    }
    
    var seconds: String {
        if (self.time%60) < 10 {
            return "0\(self.time%60)"
        } else {
            return "\(self.time%60)"
        }
    }
    
    var winner: User? {
        if self.player1.score > self.player2.score {
                return player1
            } else if self.player1.score < self.player2.score {
                return player2
            } else {
                return nil
        }
    }
    
    var alertText: String {
        guard let winner = winner else {
            return """
            Time Elapsed ⏱.
            Results : \(player1.score) / \(player2.score) !
            No winner 🤝.
            """
        }
        let loser: User
        if winner.name == player1.name {
            loser = player2
        } else {
            loser = player1
        }
        return """
        Time Elapsed ⏱.
        The winner is \(winner.name) 💪.
        Results : \(winner.score) / \(loser.score) !
        """
    }
    
    
    
    func resetSquares() {
        self.gameOver = false
        for i in 0...8 {
            squares[i].squareStatus = .empty
        }
    }
    
    func resetScores() {
        self.player1.score = 0
        self.player2.score = 0
        resetSquares()
        resetTime()
    }
    
    func resetTime() {
        self.time = 180
    }
    
    
    
    private var thereIsAWinner: SquareStatus {
        if let check = self.checkIndexes([0, 1, 2]) {
            return check
        } else  if let check = self.checkIndexes([3, 4, 5]) {
            return check
        }  else  if let check = self.checkIndexes([6, 7, 8]) {
            return check
        }  else  if let check = self.checkIndexes([0, 3, 6]) {
            return check
        }  else  if let check = self.checkIndexes([1, 4, 7]) {
            return check
        }  else  if let check = self.checkIndexes([2, 5, 8]) {
            return check
        }  else  if let check = self.checkIndexes([0, 4, 8]) {
            return check
        }  else  if let check = self.checkIndexes([2, 4, 6]) {
            return check
        } else {
            return .empty
        }
    }
    
    private func checkIndexes(_ indexes : [Int]) -> SquareStatus? {
        var circleCounter : Int = 0
        var crossCounter : Int = 0
        for index in indexes {
            let square = squares[index]
            if square.squareStatus == .circle {
                circleCounter += 1
            } else if square.squareStatus == .cross {
                crossCounter += 1
            }
        }
        if circleCounter == 3 {
            player1.score += 1
            return .circle
        } else if crossCounter == 3 {
            player2.score += 1
            return .cross
        }
        return nil
    }
    
    func playerAction(index: Int) {
        if self.currentPlayer == player1.name && squares[index].squareStatus == .empty {
            squares[index].squareStatus = .circle
            if thereIsAWinner == .circle {
                self.gameOver = true
            } else {
                nextPlayer()
                SquaresCheck()
            }
        } else if self.currentPlayer == player2.name && squares[index].squareStatus == .empty {
            squares[index].squareStatus = .cross
            if thereIsAWinner == .cross {
                self.gameOver = true
            } else {
                nextPlayer()
                SquaresCheck()
            }
        } else {
        }
    }
    
    
    private func SquaresCheck() {
        var numberEmpty = 0
        for i in squares {
            if i.squareStatus == .empty {
                numberEmpty += 1
            }
        }
        if numberEmpty == 0 {
            resetSquares()
        }
    }
    
    func nextPlayer() {
        if currentPlayer == player1.name {
            self.currentPlayer = player2.name
        } else {
            self.currentPlayer = player1.name
        }
        
    }
    
}
