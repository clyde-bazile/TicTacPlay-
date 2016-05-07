public class AIPlayer{
    
    var board: Board
    
    internal var mySeed: Seed
    internal var oppSeed: Seed
    
    var depth: Int
    
    init(board: Board, seed: Seed, depth: Int){
        self.board = board
        self.mySeed = seed
        self.oppSeed = (mySeed == .NOUGHT) ? .CROSS : .NOUGHT
        self.depth = depth
    }
    
    func eval() -> Int {
        var score: Int = 0
        let winStates = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        
        for i in winStates {
            score += evalLine(i[0], spotTwo: i[1], spotThree: i[2])
        }

        return score
    }
    
    func evalLine(spotOne: Int, spotTwo: Int, spotThree: Int) -> Int{
        var score: Int = 0
        
        // cell one
        if(board.board[spotOne] == mySeed){ score = 1 }
        else if (board.board[spotOne] == oppSeed){ score = -1 }
        
        // cellTwo
        if(board.board[spotTwo] == mySeed){
            if (score == 1){ score = 10 }
            else if (score == -1) { return 0 }
            else { score = 1 }
        }
        else if (board.board[spotTwo] == oppSeed){
            if (score == -1){ score = -10 }
            else if (score == 1) { return 0 }
            else { score = -1 }
        }
        
        // cellThree
        if(board.board[spotThree] == mySeed){
            if (score > 0){ score *= 10 }
            else if (score < 0) { return 0 }
            else { score = 1 }
        }
        else if (board.board[spotThree] == oppSeed){
            if (score < 0){ score *= 10 }
            else if (score > 1) { return 0 }
            else { score = -1 }
        }
        return score
    }
    
    func move() -> Int {
        return minimax(depth, player: mySeed, alpha: Int.min, beta: Int.max)[1]
    }
    
    func minimax(depth: Int, player: Seed, var alpha: Int, var beta: Int) -> [Int] {
        let options = board.allMoves()
        
        var score: Int = eval()
        var bestMove: Int = -1
        
        if (board.terminal() || depth == 0){
            return [score, bestMove]
        } else {
            for i in options {
                board.move(i, seed: player)
                if (player == mySeed){
                    score = minimax(depth - 1, player: oppSeed, alpha: alpha, beta: beta)[0]
                    if (score > alpha){
                        alpha = score
                        bestMove = i
                    }
                } else {
                    score = minimax(depth - 1, player: mySeed, alpha: alpha, beta: beta)[0]
                    if (score < beta){
                        beta = score
                        bestMove = i
                    }
                }
                board.move(i, seed: .EMPTY)
                if (alpha >= beta) { break }
            }
            return [(player == mySeed) ? alpha : beta, bestMove]
        }
    }
    
}