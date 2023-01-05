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
    let matchColor: (Card) -> Color
    
    var body: some View {
        GeometryReader{ geometry in
            generateShape(for: card)
                .cardify(isFaceUp: card.isFaceUp, isSelected: card.isSelected, matchColor: matchColor(card))
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
    
    return GeometryReader{ geometry in
        VStack{
            Spacer()
            ForEach(1...card.numOfShapes, id: \.self){ i in
                shape(card.shape)
                    .strokeBorder(shapeColor, lineWidth: geometry.size.width/20)
                    .background(shape(card.shape).fill(shapeColor).opacity(card.colorFeature.rawValue))
                    .padding(.vertical, geometry.size.width/20)
            }
            .aspectRatio(2, contentMode: .fit)
            Spacer()
        }
        .foregroundColor(shapeColor)
    }
}

struct Cardify: AnimatableModifier{
    var isFaceUp: Bool
    var isSelected: Bool
    var matchColor: Color
    
    func body(content: Content) -> some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            if isSelected{
                shape.shadow(color: .gray, radius: 5).edgesIgnoringSafeArea(.all)
                shape.fill().foregroundColor(Color.init(red: 0.8, green: 0.8, blue: 0.8))
            }
            else{
                shape.fill().foregroundColor(.white)
            }
            shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            if(isFaceUp){
                content
                    .padding(.leading, DrawingConstants.shapePadding)
                    .padding(.trailing, DrawingConstants.shapePadding)
            }
            else{
                shape.fill().foregroundColor(matchColor)
            }
            
        }
        .foregroundColor(matchColor)
    }
}

private struct DrawingConstants{
    static let cornerRadius: CGFloat = 15
    static let lineWidth: CGFloat = 4
    static let shapePadding: CGFloat = 15
}


extension View{
    func cardify(isFaceUp: Bool, isSelected: Bool, matchColor: Color) -> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp, isSelected: isSelected, matchColor: matchColor))
    }
}

// Code by Dávid Pásztor https://stackoverflow.com/a/65131928
struct AnyShape: InsettableShape {
    var insetAmount = 0.0
    
    init<S: InsettableShape>(_ wrapped: S) {
        _path = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }

    func path(in rect: CGRect) -> Path {
        return _path(rect)
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
            shape.insetAmount += amount
        return shape
    }

    private let _path: (CGRect) -> Path
}

// Code inspired by Dávid Pásztor
private func shape(_ shape: SetShapes) -> some InsettableShape{
    switch shape{
    case .diamond:
        return AnyShape(Diamond())
    case .oval:
        return AnyShape(Ellipse())
    case .rectangle:
        return AnyShape(Rectangle())
    }
}
