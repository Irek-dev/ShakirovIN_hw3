import Foundation

struct Position {
    var row: Int
    var col: Int

    static let directions: [(Int, Int)] = [
        (1, 0), (0, 1), (-1, 0), (0, -1), // горизонталь, вертикаль
        (1, 1), (1, -1), (-1, 1), (-1, -1) // диагонали
    ]

    func offset(by direction: (Int, Int)) -> Position {
        return Position(row: self.row + direction.0, col: self.col + direction.1)
    }
}
