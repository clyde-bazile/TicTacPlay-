//
//  ViewController.swift
//  TicTacPlay!
//
//  Created by Clyde on 3/29/16.
//  Copyright © 2016 Clyde. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var board: Board = Board()
    var currentState: GameState = .PLAYING
    var currentPlayer: Seed = .CROSS
    
    @IBOutlet weak var xWins: UILabel!
    @IBOutlet weak var oWins: UILabel!

    
    var xCount = 0
    var oCount = 0
    
    @IBOutlet weak var gameOver: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    
    
    @IBAction func playAgain(sender: AnyObject) {
        board = Board()
        currentPlayer = .CROSS
        
        var clear : UIButton
        for i in 0...8 {
            clear = view.viewWithTag(i) as! UIButton
            clear.setImage(nil, forState: .Normal)
            
        }
        gameOver.hidden = true
        currentState = .PLAYING
    }
    
    // moves the player when spot is clicked and updates label
    @IBAction func move(sender: AnyObject) {
        if board.getMove(sender.tag) == .EMPTY && currentState == .PLAYING{
            
            board.move(sender.tag, seed: currentPlayer)
            
            if currentPlayer == .CROSS {
                sender.setImage(UIImage(named: "X.png"), forState: .Normal)
                topLabel.text = "Player 2 move"
            } else {
                sender.setImage(UIImage(named: "O.png"), forState: .Normal)
                topLabel.text = "Player 1 move"
            }
            
            if (isWin() || isDraw()) {
                xWins.text = "X : \(xCount)"
                oWins.text = "O : \(oCount)"
                gameOver.hidden = false
            } else {
                currentPlayer = (currentPlayer == .NOUGHT) ? .CROSS : .NOUGHT
            }
        }
    }
    
    
    
    // determins if there's a win and updates label
    func isWin() -> Bool {
        if (!board.isWin(currentPlayer)){
            return false
        }
        if (currentPlayer == .NOUGHT){
                topLabel.text = "PLAYER 1 WINS!"
                xCount += 1
                currentState = .NOUGHT_WON
        } else {
                topLabel.text = "PLAYER 2 WINS!"
                oCount += 1
                currentState = .CROSS_WON
        }
        return true
    }
    
    // determines if there's a draw and updates label
    func isDraw() -> Bool {
        if (!board.isDraw()){
            return false
        }
        topLabel.text = "ITS A DRAW!"
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.text = ""
        xWins.text = "X : \(xCount)"
        oWins.text = "O : \(oCount)"
        gameOver.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
