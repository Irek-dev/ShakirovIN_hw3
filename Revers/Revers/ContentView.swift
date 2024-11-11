import SwiftUI

struct ContentView: View {
    @StateObject private var gameManager = GameManager()
    
    var body: some View {
        VStack {
            Text("Текущий: \(gameManager.currentPlayer == .black ? "Черный" : "Белый")")
                .font(.title)
                .padding()
            
            BoardView(board: $gameManager.board, currentPlayer: $gameManager.currentPlayer) { position in
                gameManager.makeMove(at: position)
            }
            
            Button(action: gameManager.resetGame) {
                Text("Начать игру заново")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}
