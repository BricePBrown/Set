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
            HStack{
                Text("Score: \(game.score)").font(.largeTitle).fontWeight(.bold)
                Spacer()
            }
            .padding(.leading)
            AspectVGrid(items: game.cards, aspectRatio: 2/2.75){ card in
                CardView(card: card)
                    .padding(5)
                    .onTapGesture{
                        game.choose(card)
                    }
                    .foregroundColor(game.cardMatchColor(card))
            }
            HStack{
                Spacer()
                DealButton()
                Spacer()
                Button(action: {
                    game.newGame()
                }, label: {
                    Text("New Game").foregroundColor(.accentColor)
                })
                .padding()
                .background(Color.primary)
                .clipShape(Capsule())
                Spacer()
            }
            .fontWeight(.bold)
        }
    }
    
    @ViewBuilder
    private func DealButton() -> some View {
        if(game.isDeckEmpty){
            Button(action: {
            }, label: {
                Text("Deck is Empty")
            })
            .disabled(true)
            .padding()
            .background(.gray)
            .clipShape(Capsule())
        }
        else{
            Button(action: {
                game.draw(3)
            }, label: {
                Text("Draw 3 Cards")
                    .foregroundColor(.accentColor)
            })
            .disabled(false)
            .padding()
            .background(Color.primary)
            .clipShape(Capsule())
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game).preferredColorScheme(.dark)
        SetGameView(game: game).preferredColorScheme(.light)
    }
}
