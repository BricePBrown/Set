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
                    shape.shadow(color: .gray, radius: 10)
                    shape.fill().foregroundColor(Color.init(red: 0.8, green: 0.8, blue: 0.8))
                }
                else{
                    shape.fill().foregroundColor(.white)
                }
                
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                generateShape(for: card)
                    .padding(.leading, DrawingConstants.shapePadding)
                    .padding(.trailing, DrawingConstants.shapePadding)
                
            }
        }
    }
}

private func generateShape(for card: Card) -> some View{
    
    let shapeColor: Color
    switch card.color{
    case .a:
        shapeColor = .green
    case .b:
        shapeColor = .orange
    case .c:
        shapeColor = .purple
    }
    
    return VStack{
        Spacer()
        ForEach(1...card.numOfShapes, id: \.self){ i in
            switch card.shape{
            case .diamond:
                Diamond()
            case .oval:
                Ellipse()
            case .rectangle:
                Rectangle()
            }
        }
        .aspectRatio(2, contentMode: .fit)
        Spacer()
    }
    .opacity(card.colorFeature.rawValue)
    .foregroundColor(shapeColor)
}

private struct DrawingConstants{
    static let cornerRadius: CGFloat = 15
    static let lineWidth: CGFloat = 4
    static let shapePadding: CGFloat = 10
}
