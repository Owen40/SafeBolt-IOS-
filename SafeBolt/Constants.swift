//
//  Constants.swift
//  SafeBolt
//
//  Created by mac on 11/8/25.
//

import SwiftUI

let darkBlueBackground = Color(red: 25/255, green: 25/255, blue: 40/255)
let themeBrown = Color(red: 168/255, green: 138/255, blue: 104/255)

let cardGradients: [LinearGradient] = [
    LinearGradient(colors: [themeBrown, Color(red: 120/255, green: 100/255, blue: 80/255)], startPoint: .topLeading, endPoint: .bottomTrailing),
        // 1: Purple/Blue
    LinearGradient(colors: [Color(red: 142/255, green: 68/255, blue: 173/255), Color(red: 52/255, green: 152/255, blue: 219/255)], startPoint: .topLeading, endPoint: .bottomTrailing),
        // 2: Green/Teal
    LinearGradient(colors: [Color(red: 46/255, green: 204/255, blue: 113/255), Color(red: 26/255, green: 188/255, blue: 156/255)], startPoint: .topLeading, endPoint: .bottomTrailing),
        // 3: Pink/Orange
    LinearGradient(colors: [Color(red: 231/255, green: 76/255, blue: 60/255), Color(red: 241/255, green: 196/255, blue: 15/255)], startPoint: .topLeading, endPoint: .bottomTrailing),
        // 4: Dark Slate
    LinearGradient(colors: [Color(red: 44/255, green: 62/255, blue: 80/255), Color(red: 52/255, green: 73/255, blue: 94/255)], startPoint: .topLeading, endPoint: .bottomTrailing),
        // 5: Blue/Teal (from screenshot)
    LinearGradient(colors: [Color(red: 80/255, green: 190/255, blue: 240/255), Color(red: 50/255, green: 220/255, blue: 160/255)], startPoint: .topLeading, endPoint: .bottomTrailing)

]
