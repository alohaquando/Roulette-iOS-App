//
//  TextExtension.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/20/22.
//

import SwiftUI

// Big title text with red underline
struct LineTitle: View {
    var text: String
    
    var body: some View {
        VStack(spacing: 12) {
            Text(text)
                .font(.title3)
                .bold()
            Rectangle()
                .fill(Color("red-500"))
                .frame(width: 40, height: 2)
        }
    }
}

