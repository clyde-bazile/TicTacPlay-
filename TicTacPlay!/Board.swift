

public class Board {
    
    var board : [Seed]
    
    init(){
        board = [Seed](count: 9, repeatedValue: Seed.EMPTY)
    }
    
    func isDraw() -> Bool {
        for i in 0...8{
            if (board[i] == Seed.EMPTY) {
                return false
            }
        }
        return true
    }
    
    func isWin(seed: Seed) -> Bool {
        let winStates = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        
        for wins in winStates {
            
            if (board[wins[0]] != Seed.EMPTY &&
                board[wins[0]] == board[wins[1]] &&
                board[wins[1]] == board[wins[2]] &&
                board[wins[0]] == seed )
            {
                return true
            }
        }
        return false
    }
    
    
    
    func move(cell: Int, seed: Seed) {
        board[cell] = seed
    }
    
    func getMove(cell: Int) -> Seed{
        return board[cell]
    }
}