/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: DO Hoang Quan
  ID: S3800978
  Created  date: 14/08/2022
  Last modified: 24/08/2022
  Acknowledgement:
    - https://www.zerotoappstore.com/how-to-add-background-music-in-swift.html
 
*/

//
//  ContentView.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/16/22.
//

import SwiftUI

struct ContentView: View {
    
    // Initiallize LeaderboardEntries as EnvironmentObject
    @StateObject var allEntries = LeaderboardEntries()
    
    var body: some View {
        // Pass LeaderboardEntries object to Main Menu and all other views from Main Menu
        StartScreen().environmentObject(allEntries)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
