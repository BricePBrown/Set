//
//  SetApp.swift
//  Set
//
//  Created by Brice Brown on 12/30/22.
//
// App

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
            let game = SetGameViewModel()
            SetGameView(game: game)
        }
    }
}
