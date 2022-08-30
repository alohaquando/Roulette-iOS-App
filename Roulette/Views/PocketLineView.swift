//
//  PocketLineView.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/17/22.
//

import SwiftUI

// Roulette line & spin animation
struct PocketLineView: View {
    
    // Get all pockets from data
    // Get which pocket to stop on from "GameLogic"
    let pockets: [Pocket]
    let spinTo: Int
    
    // MARK: Animation
    // Has to be chained this way because ".easeInOut(duration: )" does not work with .scrollTo
    // List of pockets duplicated and scrolled until the pocket to stop on is reached
    func Spin(proxy: ScrollViewProxy) {
        withAnimation{
            proxy.scrollTo(0-700, anchor: .center)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 10)) {
                proxy.scrollTo(34-800, anchor: .center)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 10)) {
                    proxy.scrollTo(0-700, anchor: .center)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeInOut(duration: 10)) {
                        proxy.scrollTo(0-600, anchor: .center)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeInOut(duration: 10)) {
                            proxy.scrollTo(0-500, anchor: .center)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.easeInOut(duration: 10)) {
                                proxy.scrollTo(0-400, anchor: .center)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation(.easeInOut(duration: 10)) {
                                    proxy.scrollTo(0-300, anchor: .center)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation(.easeInOut(duration: 10)) {
                                        proxy.scrollTo(0-200, anchor: .center)
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeInOut(duration: 10)) {
                                            proxy.scrollTo(0-100, anchor: .center)
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            withAnimation(.easeInOut(duration: 10)) {
                                                proxy.scrollTo(spinTo, anchor: .center)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Body
    var body: some View {
        
        // All pockets
        ScrollView{
            ScrollViewReader { value in
                
                // List of all pockets are duplicated to create the illustion of a long and looping roulette wheel
                LazyVStack (spacing: -4) {
                    
                    ForEach(pockets) { pocket in
                        PocketBlockView(pocket: pocket)
                            .id(pocket.value - 800)
                    }
                    
                    ForEach(pockets) { pocket in
                        PocketBlockView(pocket: pocket)
                            .id(pocket.value - 700)
                    }
                    
                    ForEach(pockets) { pocket in
                        PocketBlockView(pocket: pocket)
                            .id(pocket.value - 600)
                    }
                    
                    ForEach(pockets) { pocket in
                        PocketBlockView(pocket: pocket)
                            .id(pocket.value - 500)
                    }
                    
                    ForEach(pockets) { pocket in
                        PocketBlockView(pocket: pocket)
                            .id(pocket.value - 400)
                    }
                    
                    ForEach(pockets) { pocket in
                        PocketBlockView(pocket: pocket)
                            .id(pocket.value - 300)
                    }
                    
                    ForEach(pockets) { pocket in
                        PocketBlockView(pocket: pocket)
                            .id(pocket.value - 200)
                    }
                    
                    ForEach(pockets) { pocket in
                        PocketBlockView(pocket: pocket)
                            .id(pocket.value - 100)
                    }
                    
                    // MARK: Actual value of the pockets to stop on
                    ForEach(pockets) { pocket in
                        PocketBlockView(pocket: pocket)
                            .id(pocket.value)
                    }
                    
                    // Extra pockets at the end to make UI look good
                    ForEach(pockets) { pocket in
                        PocketBlockView(pocket: pocket)
                            .id(pocket.value + 100)
                    }
                }
                // Run animation when this view appear
                .onAppear {Spin(proxy: value)}
            }
            // Block user scroll
        }.simultaneousGesture(DragGesture(minimumDistance: 0), including: .all)
    }
}

struct PocketLineView_Previews: PreviewProvider {
    static var previews: some View {
        PocketLineView(pockets: allPockets, spinTo: 2)
    }
}
