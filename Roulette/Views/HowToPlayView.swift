//
//  HowToPlayView.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/18/22.
//

import SwiftUI

// View explaining how to play
struct HowToPlayView: View {
    
    // All steps
    let steps = [
        "Pick a bet amount. The default amount is $5",
        "Pick a bet options, including \"Even\" or \"Odd\"...",
        "The game will reward you based on the roulette result",
        "\"Even\", \"Odd\", \"Red\", \"Black\" will give you a 1:1 payout",
        "\"1st 12\", \"2nd 12\", \"3rd 12\" will give you a 2:1 payout",
        "End the game while you still have money to register your score",
        "Repeat and have fun"]
    
    // Body
    var body: some View {
        ZStack {
            
            // Background color
            Color("bg")
                .ignoresSafeArea()
            
            // List of all steps
            ScrollView{
                VStack (alignment: .leading, spacing: 24) {
                    
                    // Display a list item for every step in the explanation
                    ForEach(steps.indices) {i in
                        
                        // Step count
                        HStack {
                            VStack (spacing: 6){
                                Text(String(i + 1))
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
                            
                            // Step content
                            VStack(alignment: .leading, spacing: 5) {
                                Text(steps[i])
                                    .bold()
                            }
                            Spacer()
                        }
                        .background(Color("bg"))
                        .cornerRadius(18)
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("How to play")
        .navigationBarTitleDisplayMode(.large)
    }
}


struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
