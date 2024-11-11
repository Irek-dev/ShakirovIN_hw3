import Foundation

struct Board {
    var cells: [[Player?]]
    
    init() {
        cells = Array(repeating: Array(repeating: nil, count: 8), count: 8)
        cells[3][3] = .white
        cells[3][4] = .black
        cells[4][3] = .black
        cells[4][4] = .white
    }
    
    func isMoveValid(for player: Player, at position: Position) -> Bool {
        if cells[position.row][position.col] != nil { return false }
        for direction in Position.directions {
            if canCaptureInDirection(for: player, from: position, direction: direction) {
                return true
            }
        }
        return false
    }
    
    mutating func placeDisk(for player: Player, at position: Position) {
        cells[position.row][position.col] = player
        for direction in Position.directions {
            if canCaptureInDirection(for: player, from: position, direction: direction) {
                captureInDirection(for: player, from: position, direction: direction)
            }
        }
    }
    
    private func canCaptureInDirection(for player: Player, from position: Position, direction: (Int, Int)) -> Bool {
        var pos = position.offset(by: direction)
        var foundOpponent = false
        while isValidPosition(pos) {
            if cells[pos.row][pos.col] == nil { return false }
            if cells[pos.row][pos.col] == player { return foundOpponent }
            foundOpponent = true
            pos = pos.offset(by: direction)
        }
        return false
    }
    
    private mutating func captureInDirection(for player: Player, from position: Position, direction: (Int, Int)) {
        var pos = position.offset(by: direction)
        var positionsToFlip: [Position] = []
        
        // Поиск всех фишек, которые должны быть перевернуты
        while isValidPosition(pos) && cells[pos.row][pos.col] != nil && cells[pos.row][pos.col] != player {
            positionsToFlip.append(pos)
            pos = pos.offset(by: direction)
        }
        
        // Если встретилась фишка игрока, переворачиваем все собранные фишки
        if isValidPosition(pos), cells[pos.row][pos.col] == player {
            for position in positionsToFlip {
                cells[position.row][position.col] = player
            }
        }
    }
    
    private func isValidPosition(_ position: Position) -> Bool {
        position.row >= 0 && position.row < 8 && position.col >= 0 && position.col < 8
    }
    
    func isFull() -> Bool {
        for row in cells {
            if row.contains(nil) {
                return false
            }
        }
        return true
    }
    
    func hasValidMoves(for player: Player) -> Bool {
        for row in 0..<8 {
            for col in 0..<8 {
                let position = Position(row: row, col: col)
                if isMoveValid(for: player, at: position) {
                    return true
                }
            }
        }
        return false
    }
}
