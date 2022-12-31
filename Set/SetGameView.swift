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
        VStack{
            AspectVGrid(items: game.cards, aspectRatio: 2/2.75){ card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture{
                        game.choose(card)
                    }
                    .foregroundColor(game.cardMatchColor(card))
            }
            .padding(.horizontal)
            HStack{
                Spacer()
                Button(action: {
                    game.draw(3)
                }, label: {
                    Text("Deal 3 More Cards")
                })
                .padding()
                .background(.white)
                .clipShape(Capsule())
                Spacer()
                Button(action: {
                    game.newGame()
                }, label: {
                    Text("New Game")
                })
                .padding()
                .background(.white)
                .clipShape(Capsule())
                Spacer()
            }
            .fontWeight(.bold)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game).preferredColorScheme(.dark)
    }
}
