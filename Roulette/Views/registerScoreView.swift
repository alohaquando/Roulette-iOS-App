//
//  registerScoreView.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/22/22.
//

import SwiftUI

// Register high score when player chose to finish game
struct registerScoreView: View {
    
    // MARK: Declarations
    @State var playerName: String = "" // Player name for input
    @EnvironmentObject var allEntries: LeaderboardEntries // To add this score to leaderboard
    @Binding var highScore: Int // Get current score (money) from GameLogic
    @Binding var isGameOver: Bool // Set $isGameOver from GameLogic as true to finish game
    
    // This view appear as a sheet
    // To let this view dismiss itself
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    // MARK: Body
    var body: some View {
        ZStack{
            // Background color
            Color("bg").ignoresSafeArea()
            
            VStack{
                
                // Title
                Text("Enter your player name")
                
                // Player Name field
                TextField("Player name", text: $playerName)
                    .textFieldStyle(.roundedBorder)
                
                // Add score to leaderboard, set game as over, close sheet when clicked
                Button("Register score") {
                    allEntries.registerScore(entry: LeaderboardEntry(highscore: highScore, player: playerName))
                    isGameOver = true
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 32)
            }
            .padding()
        }
        .navigationTitle("Register score")
        .navigationBarBackButtonHidden()
        .interactiveDismissDisabled()
    }
}

struct registerScoreView_Previews: PreviewProvider {
    static var previews: some View {
        registerScoreView(highScore: .constant(240), isGameOver: .constant(true))
    }
}
