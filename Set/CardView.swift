//
//  CardView.swift
//  Set
//
//  Created by Brice Brown on 12/30/22.
//
// View Model for displaying a card

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isSelected{
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    generateShape(for: card)
                        .padding(5)
                        
                } else{
                    shape.fill()
                }
            }
        }
    }
}

@ViewBuilder
private func generateShape(for card: Card) -> some View{
    VStack{
        Diamond()
        Diamond()
        Diamond()
    }
}

private struct DrawingConstants{
    static let cornerRadius: CGFloat = 10
    static let lineWidth: CGFloat = 3
    static let shapePadding: CGFloat = 3
}
