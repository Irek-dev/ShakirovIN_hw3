import SwiftUI

struct BoardView: View {
    @Binding var board: Board
    @Binding var currentPlayer: Player
    var onMove: (Position) -> Void
    
    var body: some View {
        VStack {
            ForEach(0..<8) { row in
                HStack {
                    ForEach(0..<8) { col in
                        let position = Position(row: row, col: col)
                        CellView(player: $board.cells[row][col], onTap: {
                            onMove(position)
                        })
                    }
                }
            }
        }
    }
}
