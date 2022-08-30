//
//  GameLogic.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/20/22.
//


import Foundation
import SwiftUI

// Main game view
struct GameLogic: View {
    
    // MARK: DECLARATIONS
    
    // To dismiss this view and back to main menu once game is over
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State var playerMoney = 50     // Money, default 50
    @State var playerBetAmount: Int = 5     // Bet amount, default 5
    @State var playerBetChoice: String = ""     // Chosen bet
    
    @State var winningMultiplier: Int = 1   // To calculate payout (some bet pays double)
    
    // The result of the spin is randomized everytime
    // PocketSpinView uses these State to play animation and display results
    @State var thisSpinValue: Int = 0   // Spin result value, default 0, chosen randomly during play
    @State var thisSpinColor: String = ""   // Spin result color, chosen randomly during play
    @State var thisSpinWon: Bool = false    // A function will calculate if the player's bet matches the winning result
    
    @State var isGameOver: Bool = false     // If game is over, the main screen is replaced with a view to go back to main menu
    @State var didLose: Bool = false    // If player run out of money, this state is true -> play a "lose" sound effect
    
    @State var backToForeground: Bool = false   // If player resumes from home screen, this state is set to true, pause menu shown
    
    @State var showSpinSheet: Bool = false  // Show spinning roulette as a sheet after chosing bet
    @State var showFinishAlert: Bool = false    // Show alert if player press "Finish game" button
    @State var showRegisterScoreSheet: Bool = false     // Show sheet to let user register highscore
    
    let BetableAmount = [5, 10, 25, 50, 100]    // Amount of money that can be bet every turn, used with a "ForEach" to display
    
    
    // MARK: FUNCTIONS
    
    // Set the bet amount to the highest amount that is less than the money the player has
    // To ensure player can never bet more than they have
    func SetBetAmount(choice: Int) {
        if playerMoney < choice {
            for amount in BetableAmount {
                if (amount <= playerMoney) {
                    playerBetAmount = amount
                }
            }
        } else {
            playerBetAmount = choice
        }
    }
    
    // MARK: Spin, randomize winning pocket
    func Spin() {
        playSound(sound: "click", type: "wav")      // Play sound effect
        
        playerMoney -= playerBetAmount      // Detract from player money the bet amount
        
        let spinResult = allPockets.randomElement()!    // Get random pocket as winning
        thisSpinColor = spinResult.colorName    // Set color to winning pocket
        thisSpinValue = spinResult.value    // Set value to winning pocket
        
        showSpinSheet = true    // Show roulette spinning sheet
        checkGameStatus()
    }
    
    // MARK: Check game status
    // Check if player bet matches the winning pocket
    func checkGameStatus() {
        switch playerBetChoice {
            
            // Color
        case "red":
            (thisSpinColor == "red-500") ? (playerWon(multiplier: 1)) : (thisSpinWon = false)
        case "black":
            (thisSpinColor == "black") ? (playerWon(multiplier: 1)) : (thisSpinWon = false)
            
            // Value
        case "even":
            (thisSpinValue % 2 == 0) ? (playerWon(multiplier: 1)) : (thisSpinWon = false)
        case "odd":
            (thisSpinValue % 2 != 0) ? (playerWon(multiplier: 1)) : (thisSpinWon = false)
            
            // Section - double payout
        case "1st":
            (thisSpinValue >= 1 && thisSpinValue <= 12) ? (playerWon(multiplier: 2)) : (thisSpinWon = false)
        case "2nd":
            (thisSpinValue >= 13 && thisSpinValue <= 24) ? (playerWon(multiplier: 2)) : (thisSpinWon = false)
        case "3rd":
            (thisSpinValue >= 25 && thisSpinValue <= 36) ? (playerWon(multiplier: 2)) : (thisSpinWon = false)
        default:
            playerBetChoice = ""
        }
    }
    
    // MARK: Win logic
    func playerWon(multiplier: Int) {
        thisSpinWon = true      // Set spin as won to play correct animation
        winningMultiplier = multiplier      // Set multiplier depending on bet
    }
    
    // MARK: Prepare next round
    func prepNextRound() {
        showSpinSheet = false   // Dismiss spinning sheet
        
        // Add money back if spin won
        if thisSpinWon {playerMoney += playerBetAmount + (playerBetAmount * winningMultiplier)} else {
            
            // End game if player has less than 5 dollar (lower than the lowest possible bet amount)
            if (playerMoney < 5 || playerMoney == 0) {
                self.isGameOver = true
                self.didLose = true
            }
        }
        
        // Set the bet amount for the next spin
        // To make sure than player cannot bet more than they have
        SetBetAmount(choice: playerBetAmount)
    }
    
    
    
    // MARK: BODY
    var body: some View {
        
        // MARK: If game is over (either win or lose)
        if isGameOver {
            ZStack {
                
                // Background color
                Color("bg")
                    .ignoresSafeArea()
                
                VStack(spacing: 24){
                    Spacer()
                    
                    // Text
                    Text(didLose ? "Game over" : "Game finished")
                        .font(.largeTitle)
                        .bold()
                    Text(didLose ? "Finish the game with money to register your score" : "Good job on knowing when to stop\nThanks for playing")
                        .multilineTextAlignment(.center)
                    Spacer()
                    
                    // Dismiss this view, back to main menu when clicked
                    LineButton(text: "Back to main menu") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }.padding()
            }
            
            // Pick which sounds to play depending if the player chose to finish the game or run out of money
            .onAppear(perform: {
                didLose ? playSound(sound: "final-lose", type: "wav") : playSound(sound: "final-win", type: "wav")
            })
            .navigationBarBackButtonHidden()
        }
        
        // MARK: Resume game
        if backToForeground {
            ZStack {
                
                // Background color
                Color("bg")
                    .ignoresSafeArea()
                    .opacity(0.5)
                
                
                VStack(spacing: 80){
                    Spacer()
                    Text("Game paused")
                    Spacer()
                    // Hide this view -> show game view
                    LineButton(text: "Resume") {
                        backToForeground = false
                    }
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden()
        }
        
        // MARK: Game view
        if !backToForeground && !isGameOver {
            ZStack {
                // Background color
                Color("bg")
                    .ignoresSafeArea()
                
                VStack{
                    // Player Money
                    HStack{
                        Image(systemName: "dollarsign.circle")
                        Text(String(playerMoney))
                    }.padding()
                    
                    Spacer()
                    
                    VStack(spacing: 40) {
                        
                        // MARK: Title
                        Text("Place your bet")
                            .font(.largeTitle)
                            .bold()
                        
                        // MARK: Bet amount
                        HStack(spacing: -3){
                            ForEach(BetableAmount, id: \.self) {amount in
                                if (amount == playerBetAmount) {
                                    BetButtonSelected(text: "$" + (String(amount))) {
                                        SetBetAmount(choice: amount)
                                        playSound(sound: "click", type: "wav")
                                        
                                    }
                                } else {
                                    BetButton(text: "$" + (String(amount))) {
                                        SetBetAmount(choice: amount)
                                        playSound(sound: "click", type: "wav")
                                    }
                                }
                            }
                        }
                        
                        // MARK: Bet choice
                        VStack(spacing: -3){
                            
                            // Bet on color
                            HStack(spacing: -3){
                                BetShapeButton(text: "Red", shapeColor: "red-500") {
                                    playerBetChoice = "red"
                                    Spin()
                                }
                                BetShapeButton(text: "Black", shapeColor: "black") {
                                    playerBetChoice = "black"
                                    Spin()
                                }
                            }
                            
                            // Bet on value
                            HStack(spacing: -3){
                                BetButton(text: "Even") {
                                    playerBetChoice = "even"
                                    Spin()
                                }
                                BetButton(text: "Odd") {
                                    playerBetChoice = "odd"
                                    Spin()
                                }
                            }
                            
                            // Bet on section
                            HStack(spacing: -3){
                                BetButton(text: "1st 12") {
                                    playerBetChoice = "1st"
                                    Spin()
                                }
                                BetButton(text: "2nd 12") {
                                    playerBetChoice = "2nd"
                                    Spin()
                                }
                                BetButton(text: "3rd 12") {
                                    playerBetChoice = "3rd"
                                    Spin()
                                }
                            }
                        }
                    }.padding()
                    
                    
                    // MARK: Finish game button
                    // Finish game with money means player won
                    Spacer()
                    Divider()
                    LineButton(text: "Finish game") {
                        self.showFinishAlert.toggle()
                    }
                    .padding(.vertical)
                }
                
                // Sheet for spinning roulette
                .sheet(isPresented: $showSpinSheet) {
                    PocketSpinView(playerBetAmount: $playerBetAmount, playerBetChoice: $playerBetChoice, thisSpinValue: $thisSpinValue, thisSpinWon: $thisSpinWon, showSheet: $showSpinSheet) {prepNextRound()}
                }
                
                // Sheet for registering highscore
                .sheet(isPresented: $showRegisterScoreSheet) {
                    registerScoreView(highScore: $playerMoney, isGameOver: $isGameOver)
                }
                
                // Alert to finish game
                .alert("Finish game and register score?", isPresented: $showFinishAlert) {
                    Button("Finish") {
                        showRegisterScoreSheet = true
                    }
                    
                    Button("Continue playing") { }
                }
                
                // Set $backToForeground as true when resuming from homescreen
                // To show pause menu on resume
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    backToForeground = true
                }
                
                // Hide navigation bar and prevent navigation back to home screen unless game is over
                .navigationTitle("")
                .navigationBarBackButtonHidden()
                
                // Play background music when view appear
                .onAppear(perform: {
                    MusicPlayer.shared.startBackgroundMusic(backgroundMusicFileName: "casino-jazz")
                })
                .onDisappear(perform: {
                    MusicPlayer.shared.stopBackgroundMusic()
                })
            }
        }
    }
}

struct GameLogic_Preview: PreviewProvider {
    static var previews: some View {
        GameLogic()
    }
}
