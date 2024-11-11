import SwiftUI

class GridVM: ObservableObject {
    @Published var boardSize: Int = 3
    @Published var board = Array(repeating: "", count: 9)
    @Published var isXTurn = true
    @Published var gameOver = false
    @Published var winner: String? = nil
    
    // Проверка на победу
    func checkWinner() -> String? {
        let winPatterns = AI.getWinPatterns(boardSize: boardSize)
        
        for combo in winPatterns {
            let first = board[combo[0]]
            if first != "", combo.allSatisfy({ board[$0] == first }) {
                return first
            }
        }
        return nil
    }
    
    // Ход игрока
    func playerMove(at index: Int) {
        guard board[index] == "", winner == nil else { return }
        
        board[index] = isXTurn ? "X" : "O"
        
        if let win = checkWinner() {
            winner = win
            gameOver = true
        } else if !board.contains("") {
            gameOver = true
        }
        
        isXTurn.toggle()
    }
    
    // Ход ИИ
    func aiMove(at index: Int) {
        guard board[index] == "", winner == nil else { return }
        
        board[index] = "O"  // ИИ играет за O
        
        if let win = checkWinner() {
            winner = win
            gameOver = true
        } else if !board.contains("") {
            gameOver = true
        }
        
        isXTurn.toggle()
    }
    
    // Сброс игры
    func resetGame() {
        board = Array(repeating: "", count: boardSize * boardSize)
        isXTurn = true
        gameOver = false
        winner = nil
    }
}
