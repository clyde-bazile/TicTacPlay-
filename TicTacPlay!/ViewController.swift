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
    var depth = 0
    
    @IBOutlet weak var playerOne: UISegmentedControl!
    @IBOutlet weak var AISetting: UISegmentedControl!
    @IBOutlet weak var xWins: UILabel!
    @IBOutlet weak var oWins: UILabel!

    @IBOutlet weak var cell1: UIButton!
    @IBOutlet weak var cell2: UIButton!
    @IBOutlet weak var cell3: UIButton!
    @IBOutlet weak var cell4: UIButton!
    @IBOutlet weak var cell5: UIButton!
    @IBOutlet weak var cell6: UIButton!
    @IBOutlet weak var cell7: UIButton!
    @IBOutlet weak var cell8: UIButton!
    @IBOutlet weak var cell9: UIButton!
    
    var xCount = 0
    var oCount = 0
    
    @IBOutlet weak var gameOver: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    
    @IBAction func depth(sender: AnyObject) {
        if (board.isEmpty()) {
            if (AISetting.selectedSegmentIndex == 0){
                depth = 0
            } else if (AISetting.selectedSegmentIndex == 1){
                depth = 1
            } else if (AISetting.selectedSegmentIndex == 2){
                depth = 4
            } else if (AISetting.selectedSegmentIndex == 3){
                depth = 11
            }
        }
    }
    
    @IBAction func playerSettings(sender: AnyObject) {
        if (board.isEmpty()) {
            if (playerOne.selectedSegmentIndex == 1){
                aiMove()
            }
        }
    }
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
        depth(AISetting)
        playerSettings(playerOne)
    }
    
    @IBAction func move(sender: AnyObject) {
        if (board.isEmpty()){
            AISetting.enabled = false
            playerOne.enabled = false
        }
        
        if board.getMove(sender.tag) == .EMPTY &&
        (currentState == .PLAYING){
            
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
        aiMove()
    }
    
    func aiMove(){
        if (depth > 0 && currentState == .PLAYING) {
            if (board.isEmpty()){
                AISetting.enabled = false
                playerOne.enabled = false
            }
            let ai = AIPlayer(board: board, seed: currentPlayer, depth: depth)
            let move = ai.move()
            if (move != -1) {
                board.move(move, seed: currentPlayer)
                setMove(move, seed: currentPlayer)
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
    
    func setMove(int: Int, seed: Seed){
        switch int {
        case 0 :
            if seed == .CROSS {
                cell1.setImage(UIImage(named: "X.png"), forState: .Normal)
                topLabel.text = "Player 2 move"
            } else {
                cell1.setImage(UIImage(named: "O.png"), forState: .Normal)
                topLabel.text = "Player 1 move"
            }
        case 1 :
            if seed == .CROSS {
                cell2.setImage(UIImage(named: "X.png"), forState: .Normal)
                topLabel.text = "Player 2 move"
            } else {
                cell2.setImage(UIImage(named: "O.png"), forState: .Normal)
                topLabel.text = "Player 1 move"
            }
        case 2 :
            if seed == .CROSS {
                cell3.setImage(UIImage(named: "X.png"), forState: .Normal)
                topLabel.text = "Player 2 move"
            } else {
                cell3.setImage(UIImage(named: "O.png"), forState: .Normal)
                topLabel.text = "Player 1 move"
            }
        case 3 :
            if seed == .CROSS {
                cell4.setImage(UIImage(named: "X.png"), forState: .Normal)
                topLabel.text = "Player 2 move"
            } else {
                cell4.setImage(UIImage(named: "O.png"), forState: .Normal)
                topLabel.text = "Player 1 move"
        }
        case 4 :
            if seed == .CROSS {
                cell5.setImage(UIImage(named: "X.png"), forState: .Normal)
                topLabel.text = "Player 2 move"
            } else {
                cell5.setImage(UIImage(named: "O.png"), forState: .Normal)
                topLabel.text = "Player 1 move"
            }
        case 5 :
            if seed == .CROSS {
                cell6.setImage(UIImage(named: "X.png"), forState: .Normal)
                topLabel.text = "Player 2 move"
        } else {
                cell6.setImage(UIImage(named: "O.png"), forState: .Normal)
                topLabel.text = "Player 1 move"
            }
        case 6 :
            if seed == .CROSS {
                cell7.setImage(UIImage(named: "X.png"), forState: .Normal)
                topLabel.text = "Player 2 move"
            } else {
                cell7.setImage(UIImage(named: "O.png"), forState: .Normal)
                topLabel.text = "Player 1 move"
        }
        case 7 :
            if seed == .CROSS {
                cell8.setImage(UIImage(named: "X.png"), forState: .Normal)
                topLabel.text = "Player 2 move"
            } else {
                cell8.setImage(UIImage(named: "O.png"), forState: .Normal)
                topLabel.text = "Player 1 move"
            }
        case 8 :
            if seed == .CROSS {
                cell9.setImage(UIImage(named: "X.png"), forState: .Normal)
                topLabel.text = "Player 2 move"
            } else {
                cell9.setImage(UIImage(named: "O.png"), forState: .Normal)
                topLabel.text = "Player 1 move"
            }
        default:
           break
        }
    }
    
    
    
    // determins if there's a win and updates label
    func isWin() -> Bool {
        if (!board.isWin(currentPlayer)){
            return false
        }
        if (currentPlayer == .CROSS){
                topLabel.text = "PLAYER 1 WINS!"
                xCount += 1
                currentState = .CROSS_WON
        } else {
                topLabel.text = "PLAYER 2 WINS!"
                oCount += 1
                currentState = .NOUGHT_WON
        }
        AISetting.enabled = true
        playerOne.enabled = true
        return true
    }
    
    // determines if there's a draw and updates label
    func isDraw() -> Bool {
        if (!board.isDraw()){
            return false
        }
        topLabel.text = "ITS A DRAW!"
        currentState == .DRAW
        AISetting.enabled = true
        playerOne.enabled = true
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
