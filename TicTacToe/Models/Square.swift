//
//  Square.swift
//  TicTacToe
//
//  Created by Maxime Point on 04/04/2022.
//

import Foundation

enum SquareStatus {
    case empty
    case circle
    case cross
}

struct Square {
    var squareStatus : SquareStatus
    
    init(status : SquareStatus) {
        self.squareStatus = status
    }
}
