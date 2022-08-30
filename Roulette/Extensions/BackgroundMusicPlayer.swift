//
//  BackgroundMusicPlayer.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/23/22.
//

import Foundation
import AVFoundation

// To play background music on views
class MusicPlayer {
    static let shared = MusicPlayer()
    
    var audioPlayer: AVAudioPlayer?
    
    // Start playing music
    func startBackgroundMusic(backgroundMusicFileName: String) {
        if let bundle = Bundle.main.path(forResource: backgroundMusicFileName, ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else {return}
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    // Stop playing music
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else {return}
        audioPlayer.stop()
    }
}
