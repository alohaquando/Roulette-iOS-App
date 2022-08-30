//
//  LeaderboardView.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/18/22.
//

import SwiftUI

// Leaderboard screen view for all entries
struct LeaderboardView: View {
    
    // Get data from LeaderboardEntries EnvironmentObject
    @EnvironmentObject var allEntries: LeaderboardEntries
    
    var body: some View {
        ZStack {
            
            // Background color
            Color("bg")
                .ignoresSafeArea()
            
            // List of all entries
            ScrollView{
                VStack(spacing: 0){
                    ForEach((allEntries.getEntries()).indices) { i in
                        LeaderboardEntryView(ranking: i + 1, score: self.allEntries.entries[i].highscore, player: self.allEntries.entries[i].player)
                    }
                }
            }
            .navigationTitle("Leaderboard")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView().environmentObject(LeaderboardEntries())
    }
}
