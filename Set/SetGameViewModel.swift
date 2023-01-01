//
//  SetGameViewModel.swift
//  Set
//
//  Created by Brice Brown on 12/30/22.
//
// View Model for SetGame

import SwiftUI

class SetGameViewModel: ObservableObject {
    
    private static func createSetGame() -> SetGame{
        SetGame()
    }
    
    @Published private var model = createSetGame()
    
    var cards: [Card]{
        return model.cards
    }
    
    var isDeckEmpty: Bool{
        return model.deck.isEmpty
    }
    
    var score: Int{
        return model.playerScore
    }
    
    // MARK: - Intents(s)
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func draw(_ numberOfNewCards: Int){
        if (!cards.filter{$0.isMatched == .correct}.isEmpty) {
            model.removeMatchingCards()
        }
        else{
            model.draw(numberOfNewCards)
        }
    }
    
    func newGame(){
        model = SetGame()
    }
    
    func cardMatchColor(_ card: Card) -> Color{
        let matchStatus: Color
        
        if(card.isMatched == .incorrect){
            matchStatus = .red
        } else if (card.isMatched == .correct){
            matchStatus = .blue
        } else {
            matchStatus = .gray
        }
        
        return matchStatus
    }
}

