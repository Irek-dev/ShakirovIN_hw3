import Foundation

class GameManager: ObservableObject {
    @Published var showGame: Bool = false
    @Published var boardSize: Int = 3
    @Published var isPlayingAgainstComputer: Bool = false
    @Published var computerFirst: Bool = false
}
