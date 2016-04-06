//
//  ViewController.swift
//  TicTacPlay!
//
//  Created by Clyde on 3/29/16.
//  Copyright © 2016 Clyde. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isActive = true
    var player = 1 // 1 = x; 2 = o;
    var board = [0,0,0,0,0,0,0,0,0]
    let temp = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    @IBOutlet weak var xWins: UILabel!
    @IBOutlet weak var oWins: UILabel!

    
    var xCount = 0
    var oCount = 0
    
    @IBOutlet weak var gameOver: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    
    
    @IBAction func playAgain(sender: AnyObject) {
        board = [0,0,0,0,0,0,0,0,0]
        player = 1
        
        var clear : UIButton
        for i in 0...8 {
            clear = view.viewWithTag(i) as! UIButton
            clear.setImage(nil, forState: .Normal)
            
        }
        gameOver.hidden = true
        isActive = true
    }
    
    // moves the player when spot is clicked and updates label
    @IBAction func move(sender: AnyObject) {
        if board[sender.tag] == 0 && isActive{
            
            board[sender.tag] = player
            
            if player == 1 {
                sender.setImage(UIImage(named: "X.png"), forState: .Normal)
                player = 2
                topLabel.text = "Player 2 move"
            } else {
                sender.setImage(UIImage(named: "O.png"), forState: .Normal)
                player = 1
                topLabel.text = "Player 1 move"
            }
            if (isWin() || isDraw()) {
                isActive = false
                xWins.text = "X : \(xCount)"
                oWins.text = "O : \(oCount)"
                gameOver.hidden = false
            }
        }
    }
    
    // determins if there's a win and updates label
    func isWin() -> Bool {
        for wins in temp {
            
            if (board[wins[0]] != 0 &&
                board[wins[0]] == board[wins[1]] &&
                board[wins[1]] == board[wins[2]])
            {
                if (board[wins[0]] == 1){
                    topLabel.text = "PLAYER 1 WINS!"
                    xCount += 1
                } else {
                    topLabel.text = "PLAYER 2 WINS!"
                    oCount += 1
                }
                return true
            }
        }
        return false
    }
    
    // determines if there's a draw and updates label
    func isDraw() -> Bool {
        for i in 0...8 {
            if board[i] == 0 {
                return false
            }
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

