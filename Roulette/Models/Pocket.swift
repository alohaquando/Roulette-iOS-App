//
//  Pocket.swift
//  Roulette
//
//  Created by Quân Đỗ on 8/17/22.
//

import SwiftUI

// Roulette pocket struct declaration
struct Pocket: Identifiable {
    var id: String{String(value)}
    let value: Int
    let colorName: String
    var color: Color{Color(colorName)}
}

// All pockets
let allPockets = [
    Pocket(value: 0, colorName: "green-500"),
    Pocket(value: 1, colorName: "red-500"),
    Pocket(value: 2, colorName: "black"),
    Pocket(value: 3, colorName: "red-500"),
    Pocket(value: 4, colorName: "black"),
    Pocket(value: 5, colorName: "red-500"),
    Pocket(value: 6, colorName: "black"),
    Pocket(value: 7, colorName: "red-500"),
    Pocket(value: 8, colorName: "black"),
    Pocket(value: 9, colorName: "red-500"),
    Pocket(value: 10, colorName: "black"),
    Pocket(value: 11, colorName: "black"),
    Pocket(value: 12, colorName: "red-500"),
    Pocket(value: 13, colorName: "black"),
    Pocket(value: 14, colorName: "red-500"),
    Pocket(value: 15, colorName: "black"),
    Pocket(value: 16, colorName: "red-500"),
    Pocket(value: 17, colorName: "black"),
    Pocket(value: 18, colorName: "red-500"),
    Pocket(value: 19, colorName: "red-500"),
    Pocket(value: 20, colorName: "black"),
    Pocket(value: 21, colorName: "red-500"),
    Pocket(value: 22, colorName: "black"),
    Pocket(value: 23, colorName: "red-500"),
    Pocket(value: 24, colorName: "black"),
    Pocket(value: 25, colorName: "red-500"),
    Pocket(value: 26, colorName: "black"),
    Pocket(value: 27, colorName: "red-500"),
    Pocket(value: 28, colorName: "black"),
    Pocket(value: 29, colorName: "black"),
    Pocket(value: 30, colorName: "red-500"),
    Pocket(value: 31, colorName: "black"),
    Pocket(value: 32, colorName: "red-500"),
    Pocket(value: 33, colorName: "black"),
    Pocket(value: 34, colorName: "red-500"),
    Pocket(value: 35, colorName: "red-500"),
    Pocket(value: 36, colorName: "red-500")
]
