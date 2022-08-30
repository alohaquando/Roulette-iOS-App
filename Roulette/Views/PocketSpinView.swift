//
//  PocketSpinView.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/17/22.
//

import SwiftUI

// Display roulette spin animation, bet information, result of spin
struct PocketSpinView: View {
    
    // MARK: Declarations
    
    // Bind to data sent from GameLogic
    @Binding var playerBetAmount: Int
    @Binding var playerBetChoice: String
    @Binding var thisSpinValue: Int
    @Binding var thisSpinWon: Bool
    
    // Bind to @State from GameLogic
    // This view is called as a sheet in GameLogic
    // To let this view close itself once it is finished with all animation
    @Binding var showSheet: Bool
    
    // For animation
    @State var animateStar: Bool = false
    @State var animateLose: Bool = false
    
    // Show spin result as an overlay
    @State var showOverlay: Bool = false
    
    // Call this function which is defined in GameLogic
    // Passed to this view so that this function is only called once the result has been shown
    // Because this view appear as a sheet, if the result are calculated and displayed immediately, users can tell if won or lost
    let prepNextRoundFunc: () -> Void
    
    // Timer for countdown
    @State private var countdown = 3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // MARK: Body
    var body: some View {
        ZStack {
            // Background color
            Color("bg").ignoresSafeArea()
            
            ZStack {
                VStack (spacing: 50) {
                    
                    // MARK: Bet information
                    Text("You're betting $" + String(playerBetAmount) + " on " + playerBetChoice)
                        .fontWeight(.semibold)
                        .opacity(0.6)
                    
                    // MARK: Roulette and pointer
                    HStack {
                        Image(systemName: "arrowtriangle.forward.fill")
                            .font(.largeTitle)
                            .padding(.trailing, 25)
                        
                        ZStack{
                            PocketLineView(pockets: allPockets, spinTo: thisSpinValue)
                                .frame(width: 100, height: 500)
                                .clipped()
                            VStack{
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(
                                        LinearGradient(gradient: Gradient(colors: [Color("bg"), .clear]), startPoint: .top, endPoint: .bottom)
                                    )
                                Spacer()
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(
                                        LinearGradient(gradient: Gradient(colors: [ .clear, Color("bg")]), startPoint: .top, endPoint: .bottom)
                                    )
                            }
                        }
                        .frame(width: 100, height: 500)
                    }
                }
            }
            
            // MARK: Result overlay
            if (showOverlay) {
                ZStack {
                    Color("bg")
                        .opacity(0.96)
                        .ignoresSafeArea()
                    VStack{
                        
                        // MARK: Star animation if won
                        if(thisSpinWon) {
                            Image("star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                                .scaleEffect(self.animateStar ? 3 : 1)
                                .rotationEffect(.degrees(self.animateStar ? 360.0 : 0.0))
                                .offset(y: self.animateStar ? -60 : 0)
                                .animation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10, initialVelocity: 2), value: self.animateStar)
                        }
                        
                        // MARK: Result and countdown
                        // Title
                        Text(thisSpinWon ? "You won!" : "You lose")
                            .font(.largeTitle)
                            .bold()
                            .padding(.bottom, 48)
                            .padding(.top, 24)
                            .rotationEffect(.degrees(self.animateLose ? 12.0 : 0.0))
                            .animation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10, initialVelocity: 2), value: self.animateLose)
                            .scaleEffect(self.animateLose ? 2 : 1)
                        
                        // Countdown
                        Text("Next game begin in\n")
                            .font(.subheadline)
                        Text("\(countdown)")
                            .onReceive(timer) { time in
                                if countdown > 1 {
                                    countdown -= 1
                                } else {
                                    prepNextRoundFunc()
                                }
                            }
                    }
                }
                
                // MARK: Start win or lose animation when overlay appear
                .onAppear(perform: {
                    if thisSpinWon {
                        playSound(sound: "win", type: "wav")
                        animateStar = true
                    } else {
                        playSound(sound: "lose", type: "wav")
                        animateLose = true
                    }
                    
                })
                .animation(.easeInOut(duration: 5), value: 5)
            }
        }
        .task({await delayOverlay()}) // Start countdown
        .interactiveDismissDisabled() // Block swipe down to dismiss sheet
        // Play spinning sound
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                playSound(sound: "spin", type: "wav")
            }
        })
    }
    
    // Delay overlay for the amount of time the spinning animation is ran (3.5 seconds)
    private func delayOverlay() async {
        try? await Task.sleep(nanoseconds: 3_500_000_000)
        showOverlay = true
    }
    
}

struct PocketSpinView_Previews: PreviewProvider {
    static var previews: some View {
        PocketSpinView(playerBetAmount: .constant(50), playerBetChoice: .constant("even"), thisSpinValue: .constant(24), thisSpinWon: .constant(false), showSheet: .constant(true)) {}
    }
}
