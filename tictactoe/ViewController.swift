//
//  ViewController.swift
//  tictactoe
//
//  Created by Andrew Carter on 2/2/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet var currentPlayerLabel: UILabel!
    @IBOutlet var xWinsLabel: UILabel!
    @IBOutlet var oWinsLabel: UILabel!
    @IBOutlet var ticTacButtons: [TicTacButton]!
    var currentPlayer: Player = .x
    var playerXWins = 0
    var playerYWins = 0
    
    // MARK: - UIViewController Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetForInitialGameState()
    }
    
    // MARK: - Instance Methods
    
    @IBAction func ticTacButtonPressed(sender: TicTacButton) {
        sender.claim(for: currentPlayer)
        
        let winningPlayer = checkWinningPlayer()
        let movesRemain = ticTacButtons.contains(where: { $0.claimingPlayer == nil })
        
        if let winningPlayer = winningPlayer {
            playerDidWin(winningPlayer)
        } else if !movesRemain {
            stalemateDidOccur()
        } else {
            currentPlayer = currentPlayer == .x ? .o : .x
            updateCurrentPlayerLabel()
        }
    }
    
    func playerDidWin(_ player: Player) {
        switch player {
        case .x:
            playerXWins += 1
            
        case .o:
            playerYWins += 1
        }
        
        let controller = UIAlertController(title: "Player \(player.displayString) Win", message: nil, preferredStyle: .alert)

        controller.addAction(.init(title: "Reset", style: .destructive, handler: { _ in
            self.resetForInitialGameState()
        }))
        
        controller.addAction(.init(title: "Next Round", style: .default, handler: { _ in
            self.resetForNextRound()
        }))

        present(controller, animated: true)
    }
    
    func stalemateDidOccur() {
        let controller = UIAlertController(title: "Stalemate", message: nil, preferredStyle: .alert)
        
        controller.addAction(.init(title: "Reset", style: .destructive, handler: { _ in
            self.resetForInitialGameState()
        }))
        
        controller.addAction(.init(title: "Next Round", style: .default, handler: { _ in
            self.resetForNextRound()
        }))
        
        present(controller, animated: true)
    }
    
    func checkWinningPlayer() -> Player? {
        let gameState = ticTacButtons!.map({ $0.claimingPlayer })
        
        // Horizontal win check
        for rowOffset in stride(from: 0, to: 6, by: 3) {
            let values = gameState[rowOffset ..< rowOffset+3]
            guard let value = values.first,
                  let claimingPlayer = value else {
                      continue
                  }
            
            let claimingPlayerWins = values.allSatisfy({ $0 == claimingPlayer })
            guard !claimingPlayerWins else {
                return claimingPlayer
            }
        }
        
        // Vertical win check
        for columnOffset in stride(from: 0, to: 3, by: 1) {
            let values = [gameState[columnOffset], gameState[columnOffset + 3], gameState[columnOffset + 6]]
            guard let value = values.first,
                  let claimingPlayer = value else {
                      continue
                  }
            
            let claimingPlayerWins = values.allSatisfy({ $0 == claimingPlayer })
            guard !claimingPlayerWins else {
                return claimingPlayer
            }
        }

        // Diagonal win check
        let diagonalWin = [gameState[0], gameState[4], gameState[8]]
        guard let value = diagonalWin.first,
              let claimingPlayer = value else {
                  return nil
              }
        
        let claimingPlayerWins = diagonalWin.allSatisfy({ $0 == claimingPlayer })
        guard !claimingPlayerWins else {
            return claimingPlayer
        }
        
        return nil
    }
    
    func resetForNextRound() {
        currentPlayer = .x
        resetButtons()
        updateCurrentPlayerLabel()
        updateWinsLabels()
    }
    
    func resetForInitialGameState() {
        playerYWins = 0
        playerXWins = 0
        currentPlayer = .x
        resetButtons()
        updateCurrentPlayerLabel()
        updateWinsLabels()
    }
    
    func resetButtons() {
        ticTacButtons.forEach { button in
            button.unclaim()
        }
    }
    
    func updateCurrentPlayerLabel() {
        currentPlayerLabel.text = currentPlayer.displayString
    }
    
    func updateWinsLabels() {
        xWinsLabel.text = String(playerXWins)
        oWinsLabel.text = String(playerYWins)
    }
    
}
