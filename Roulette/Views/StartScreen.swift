//
//  StartScreen.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/18/22.
//

import SwiftUI

// Game main menu
struct StartScreen: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                Color("bg").ignoresSafeArea()
                VStack{
                    
                    // Game title
                    Spacer()
                    Text("roulette")
                        .font(.largeTitle)
                    Spacer()
                    
                    // Navigations to different screens
                    VStack (spacing: 48) {
                        
                        // To game
                        NavigationLink(destination: GameLogic()) {
                            LineTitle(text: "Play")
                        }
                        .buttonStyle(PlainButtonStyle())
            
                        // To leaderboard
                        NavigationLink(destination: LeaderboardView()) {
                            LineTitle(text: "Leaderboard")
                        }.buttonStyle(PlainButtonStyle())
                        
                        // To how to play
                        NavigationLink(destination: HowToPlayView()) {
                            LineTitle(text: "How to play")
                        }.buttonStyle(PlainButtonStyle())
                    }
                    Spacer()
                }
            }
        }
        // Play music when view appear and stop on dissappear
        .onAppear(perform: {
            MusicPlayer.shared.startBackgroundMusic(backgroundMusicFileName: "lobby-time")
        })
        .onDisappear(perform: {
            MusicPlayer.shared.stopBackgroundMusic()
        })
        .navigationViewStyle(StackNavigationViewStyle()) // Prevent automatic sidebar on iPad and macOS
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen().environmentObject(LeaderboardEntries())
    }
}
