import SwiftUI

struct GameSettingsS: View {
    @EnvironmentObject var gameManager: GameManager
    @State var boardSize = 3
    @State var playAgainstComputer = false
    @State var computerFirst = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("Размер поля: \(gameManager.boardSize)x\(gameManager.boardSize)")
                Slider(value: Binding(
                    get: { Double(gameManager.boardSize) },
                    set: { newValue in gameManager.boardSize = Int(newValue) }
                ), in: 3...10, step: 1)
                .padding()

                Toggle("Играть с компьютером", isOn: $playAgainstComputer)
                    .padding()

                if playAgainstComputer {
                    Toggle("Компьютер ходит первым", isOn: $computerFirst)
                        .padding()
                }

                Button {
                    gameManager.isPlayingAgainstComputer = playAgainstComputer
                    gameManager.computerFirst = computerFirst
                    gameManager.showGame = true
                } label: {
                    Text("Start")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                }
                Spacer()
            }
            .navigationTitle("Tic Tac Toe")
        }
    }
}

#Preview {
    GameSettingsS()
}
