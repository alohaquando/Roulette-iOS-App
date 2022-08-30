//
//  LeaderboardEntryView.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/18/22.
//

import SwiftUI

// UI for each entry on the leaderboard
struct LeaderboardEntryView: View {
    let ranking: Int
    let score: Int
    let player: String
    
    var body: some View {
        HStack () {
            
            // Ranking
            VStack (spacing: 6){
                Text(String(ranking))
                    .font(.callout)
                    .bold()
                Rectangle()
                    .fill(Color("red-500"))
                    .frame(width: 20, height: 2)
            }
            .frame(width: 40)
            
            // Divider
            Rectangle()
                .opacity(0.25)
                .frame(width: 1, height: 54)
                .padding(.trailing, 8)
            
            // Score and playername
            VStack(alignment: .leading, spacing: 5) {
                Text(String(score))
                    .bold()
                HStack {
                    Image(systemName: "person.fill")
                        .padding(.trailing, -4)
                    Text(player)
                }.opacity(0.5)
            }
            Spacer()
        }
        
        // Background and padding
        .padding(16)
        .background(Color("bg"))
        .cornerRadius(18)
        
    }
}

struct LeaderboardEntryView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardEntryView(ranking: 1, score: 1000000, player: "sheenathan")
    }
}
