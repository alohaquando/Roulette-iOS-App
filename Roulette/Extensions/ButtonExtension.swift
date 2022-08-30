//
//  ButtonExtension.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/20/22.
//

import SwiftUI

// Button style for selecting bet amount - unselected
struct BetButton: View {
    var text: String
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: clicked) {
            Text(text)
                .bold()
                .padding([.top, .bottom])
                .frame(maxWidth: .infinity)
                .border(Color("bg-flipped"), width: 3)
        }.buttonStyle(PlainButtonStyle())
    }
}

// Button style for selecting bet amount - selected
struct BetButtonSelected: View {
    var text: String
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: clicked) {
            Text(text)
                .foregroundColor(.white)
                .bold()
                .padding([.top, .bottom])
                .frame(maxWidth: .infinity)
                .border(Color("bg-flipped"), width: 3)
                .background(Color("red-500"))
        }.buttonStyle(PlainButtonStyle())
    }
}

// Button style for bet options
struct BetShapeButton: View {
    var text: String
    var shapeColor: String
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: clicked) {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(shapeColor))
                    .frame(width: 80, height: 80)
                    .cornerRadius(5)
                    .rotationEffect(Angle(degrees: 45))
                Text(text)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 150)
            .border(Color("bg-flipped"), width: 3)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Button style for "Finish game" and other title with red underline
struct LineButton: View {
    var text: String
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: clicked) {
            VStack(spacing: 12) {
                Text(text)
                    .font(.title3)
                    .bold()
                Rectangle()
                    .fill(Color("red-500"))
                    .frame(width: 40, height: 2)
            }
        }.buttonStyle(PlainButtonStyle())
    }
}
