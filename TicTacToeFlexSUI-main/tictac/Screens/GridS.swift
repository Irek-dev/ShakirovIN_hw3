import SwiftUI

struct GridS: View {
    @StateObject var viewModel = GridVM()
    @EnvironmentObject var gameManager: GameManager

    var body: some View {
        VStack {
            Spacer()

            Text(viewModel.isXTurn && !viewModel.gameOver ? "Ход Х" : " ")

            if let winner = viewModel.winner {
                Text("\(winner) выиграл!")
                    .font(.largeTitle)
                    .padding()
            } else if viewModel.gameOver {
                Text("Ничья!")
                    .font(.largeTitle)
                    .padding()
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: viewModel.boardSize), spacing: 10) {
                ForEach(0..<viewModel.boardSize * viewModel.boardSize, id: \.self) { index in
                    ZStack {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 0.9 * (UIScreen.main.bounds.width / CGFloat(viewModel.boardSize)), height: (UIScreen.main.bounds.width / CGFloat(viewModel.boardSize)) * 0.9)
                            .cornerRadius(10)

                        Text(viewModel.board[index])
                            .font(.system(size: (UIScreen.main.bounds.width / CGFloat(viewModel.boardSize)) * 0.7))
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        viewModel.playerMove(at: index)
                    }
                }
            }
            .padding()

            Text(!viewModel.isXTurn && !viewModel.gameOver ? "Ход O" : " ")

            Spacer()

            Button("Новая игра") {
                viewModel.resetGame()
            }
            .padding()
            Button("Вернуться в меню") {
                gameManager.showGame.toggle()
            }
        }
        .onAppear(perform: {
            viewModel.boardSize = gameManager.boardSize
            viewModel.resetGame()
        })
        .onChange(of: viewModel.isXTurn) { _ in
            // Игрок и ИИ делают ходы поочередно
            if !viewModel.isXTurn && !viewModel.gameOver && gameManager.isPlayingAgainstComputer {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Делаем задержку для хода ИИ
                    let move = AI.findBestMove(board: viewModel.board, boardSize: viewModel.boardSize, isXTurn: false)
                    viewModel.aiMove(at: move ?? 0) // ИИ делает ход
                }
            }
        }
    }
}

#Preview {
    GridS()
}
