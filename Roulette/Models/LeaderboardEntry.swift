//
//  LeaderboardEntry.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/21/22.
//

import Foundation

// Leaderboard entry class, set as EnvironmentObject later
class LeaderboardEntry : Identifiable, Codable {
    var id = UUID()
    let highscore: Int
    let player: String
    
    init(highscore: Int, player: String) {
        self.id = UUID()
        self.highscore = highscore
        self.player = player
    }
}

// All entries on the leaderboard
@MainActor class LeaderboardEntries: ObservableObject {
    
    // Publish all entries to be used
    @Published var entries: [LeaderboardEntry]
    
    // Set all entries with data from UserDefaults
    init() {
        if let data = UserDefaults.standard.data(forKey: "LeaderboardEntries") {
            if let decodedData = try? JSONDecoder().decode([LeaderboardEntry].self, from: data) {
                entries = decodedData.sorted(by: {$0.highscore > $1.highscore})
                return
            }
        }
        
        // Set entries from sample data if no UserDefaults data available
        entries = [LeaderboardEntry(highscore: 50, player: "beginnerperson"),
                   LeaderboardEntry(highscore: 100, player: "psychologist"),
                   LeaderboardEntry(highscore: 200, player: "laurentforsomereason"),
                   LeaderboardEntry(highscore: 300, player: "mooncakewoman"),
                   LeaderboardEntry(highscore: 400, player: "alohaquan"),
                   LeaderboardEntry(highscore: 500, player: "sheenathan")]
    }
    
    // ! EXTRA FUNCTION
    // Register new score with player name
    func registerScore(entry: LeaderboardEntry) {
        entries.append(entry)
        
        entries = entries.sorted(by: {$0.highscore > $1.highscore})

        // Save new data to UserDefaults
        if let encodedData = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encodedData, forKey: "LeaderboardEntries")
            return
        }
    }
    
    // Return all entries sorted from high to low (leaderboard should show highest score first)
    func getEntries() -> [LeaderboardEntry] {
        var sortedEntries = entries.sorted(by: {$0.highscore > $1.highscore})
        return sortedEntries
    }
}
