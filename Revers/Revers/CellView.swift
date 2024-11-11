import SwiftUI

struct CellView: View {
    @Binding var player: Player?
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 40, height: 40)
                
                if let player = player {
                    Circle()
                        .fill(player == .black ? Color.black : Color.white)
                        .frame(width: 30, height: 30)
                }
            }
        }
        .disabled(player != nil)
    }
}
