//
//  SFXPlayer.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/23/22.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

// To play sound effect during game play
func playSound(sound: String, type: String) {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      audioPlayer?.play()
    } catch {
      print(error)
    }
  }
}
