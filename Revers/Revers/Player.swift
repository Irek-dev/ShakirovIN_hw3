import Foundation

enum Player {
    case black
    case white
    
    var opponent: Player {
        switch self {
        case .black: return .white
        case .white: return .black
        }
    }
}
