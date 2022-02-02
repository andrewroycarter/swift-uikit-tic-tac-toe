//
//  Player.swift
//  tictactoe
//
//  Created by Andrew Carter on 2/2/22.
//

import Foundation

enum Player {
    case x
    case o
    
    var displayString: String {
        switch self {
        case .x:
            return "X"
            
        case .o:
            return "O"
        }
    }
}
