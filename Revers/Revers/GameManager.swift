import Foundation

class GameManager: ObservableObject {
    @Published var board: Board
    @Published var currentPlayer: Player
    
    init() {
        board = Board()
        currentPlayer = .black
    }
    
    func makeMove(at position: Position) {
        guard board.isMoveValid(for: currentPlayer, at: position) else { return }
        board.placeDisk(for: currentPlayer, at: position)
        
        if board.hasValidMoves(for: currentPlayer.opponent) {
            currentPlayer = currentPlayer.opponent
        }
    }
    
    func resetGame() {
        board = Board()
        currentPlayer = .black
    }
}
