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
    
    //always private
    @Namespace private var discardNamespace
    
    var body: some View {
        VStack{
            
            Text("Score: \(game.score)").font(.largeTitle).fontWeight(.bold).padding().frame(maxWidth: .infinity, alignment: .leading)
            gameBody
            HStack{
                    VStack(alignment: .trailing){
                        newGameButton
                    }
                    .fontWeight(.bold)
                    .padding(.trailing)
                    HStack{
                        // Deck
                        deckBody
                            .aspectRatio(2/2.75, contentMode: .fit)
                        // Discard Pile
                        discardPile
                            .aspectRatio(2/2.75, contentMode: .fit)
                    }
            }
            .padding()
        }
    }
    
    private func zIndex(of card: Card) -> Double {
            -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
        }
    
    private var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/2.75){ card in
            CardView(card: card, matchColor: game.cardMatchColor)
                .matchedGeometryEffect(id: card.id, in: discardNamespace)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                .zIndex(zIndex(of: card))
                .padding(5)
                .onTapGesture{
                    withAnimation(){
                        game.choose(card)
                    }
                }
        }
    }
    
    private var deckBody: some View {
        ZStack{
            if(!game.isDeckEmpty){
            ForEach(game.deck){ card in
                CardView(card: card, matchColor: game.cardMatchColor)
                    .matchedGeometryEffect(id: card.id, in: discardNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
            .onTapGesture {
                withAnimation{
                        game.draw(3)
                }
            }
            }else{
                Text("").cardify(isFaceUp: true, isSelected: false, matchColor: .clear)
            }
        }
    }
    
    private var discardPile: some View {
        ZStack{
            if game.discardPile.isEmpty{
                Text("")
                    .cardify(isFaceUp: false, isSelected: false, matchColor: .gray)
            }
            else {
                ForEach(game.discardPile){ card in
                    CardView(card: card, matchColor: game.cardMatchColor)
                        .matchedGeometryEffect(id: card.id, in: discardNamespace)
                        .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                        .zIndex(zIndex(of: card))
                }
            }
            
        }
    }
    
    private var newGameButton: some View {
        Button("New Game") {
            withAnimation(){
                game.newGame()
            }
        }
        .foregroundColor(.accentColor)
        .padding()
        .background(Color.primary)
        .clipShape(Capsule())
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game).preferredColorScheme(.dark)
        SetGameView(game: game).preferredColorScheme(.light)
    }
}
