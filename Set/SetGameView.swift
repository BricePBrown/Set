//
//  SetGameView.swift
//  Set
//
//  Created by Brice Brown on 12/30/22.
//
// VIEW for set game

import SwiftUI

struct SetGameView: View {
    
    // view model for Set Game
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3){ card in
            CardView(card: card)
                .padding(4)
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game).preferredColorScheme(.dark)
    }
}
