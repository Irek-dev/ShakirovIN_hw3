import Foundation

class AI {
    
    // Функция для нахождения лучшего хода для ИИ
    static func findBestMove(board: [String], boardSize: Int, isXTurn: Bool) -> Int? {
        let availableMoves = board.enumerated().filter { $0.element == "" }.map { $0.offset }
        
        // Для начала проверим, может ли ИИ выиграть или предотвратить победу игрока
        if let winningMove = findWinningMove(board: board, availableMoves: availableMoves, isXTurn: isXTurn) {
            return winningMove
        }
        
        // Если ИИ не может выиграть, предотвращаем победу игрока
        if let preventPlayerWin = findWinningMove(board: board, availableMoves: availableMoves, isXTurn: !isXTurn) {
            return preventPlayerWin
        }
        
        // Если выигрыш или предотвращение победы невозможно, то выбираем случайный ход
        return availableMoves.randomElement()
    }
    
    // Функция для нахождения выигрышного хода (если он есть) для текущего игрока
    private static func findWinningMove(board: [String], availableMoves: [Int], isXTurn: Bool) -> Int? {
        let winPatterns = getWinPatterns(boardSize: Int(sqrt(Double(board.count))))  // Получаем паттерны для поля
        let playerSymbol = isXTurn ? "X" : "O"
        
        for move in availableMoves {
            var tempBoard = board
            tempBoard[move] = playerSymbol
            
            // Проверяем, приводит ли данный ход к победе
            if checkWinner(board: tempBoard, playerSymbol: playerSymbol, winPatterns: winPatterns) {
                return move
            }
        }
        return nil
    }
    
    // Проверка на победу игрока или ИИ
    private static func checkWinner(board: [String], playerSymbol: String, winPatterns: [[Int]]) -> Bool {
        for pattern in winPatterns {
            if pattern.allSatisfy({ board[$0] == playerSymbol }) {
                return true
            }
        }
        return false
    }
    
    // Функция для получения паттернов выигрыша (по строкам, столбцам и диагоналям)
    static func getWinPatterns(boardSize: Int) -> [[Int]] {
        var patterns = [[Int]]()
        
        // Строки
        for i in 0..<boardSize {
            patterns.append((0..<boardSize).map { i * boardSize + $0 })
        }
        
        // Столбцы
        for i in 0..<boardSize {
            patterns.append((0..<boardSize).map { i + $0 * boardSize })
        }
        
        // Диагонали
        let diag1 = (0..<boardSize).map { $0 * (boardSize + 1) }
        let diag2 = (0..<boardSize).map { ($0 + 1) * (boardSize - 1) }
        
        patterns.append(diag1)
        patterns.append(diag2)
        
        return patterns
    }
}
