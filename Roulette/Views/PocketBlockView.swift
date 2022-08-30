//
//  PocketBlockView.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/17/22.
//

import SwiftUI

// UI for each pocket on the roulette
struct PocketBlockView: View {
    let pocket: Pocket
    var body: some View {
            Text(String(pocket.value))
                .foregroundColor(.white)
                .bold()
                .font(.largeTitle)
                .frame(width: 100, height: 100)
                .background(pocket.color)
                .border(Color(.white), width: 5)
        
    }
}

struct PocketBlockView_Previews: PreviewProvider {
    static var previews: some View {
        PocketBlockView(pocket: allPockets[1])
    }
}
