//
//  TicTacButton.swift
//  tictactoe
//
//  Created by Andrew Carter on 2/2/22.
//

import Foundation
import UIKit

class TicTacButton: UIButton {
    
    // MARK: - Properties
    
    static let placeholderPosition = -1

    @IBInspectable var position: Int = TicTacButton.placeholderPosition
    
    private (set) var claimingPlayer: Player?
    
    // MARK: - Instance Methods
    
    func claim(for player: Player) {
        claimingPlayer = player
        setTitle(player.displayString, for: .normal)
    }
    
    func unclaim() {
        claimingPlayer = nil
        setTitle("", for: .normal)
    }
}
