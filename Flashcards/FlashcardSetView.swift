//
//  FlashcardSetView.swift
//  Flashcards
//
//  Created by Big Guy on 11/18/25.
//

import SwiftUI

struct FlashcardSetView: View {
    @Binding var flashcardSet: FlashcardSet
    
    @State private var index = 0
    @State private var showingAnswer = false
    
    func addCard(question: String, answer: String) {
        flashcardSet.cards.append(
            Flashcard(id: UUID(), question: question, answer: answer)
        )
    }
    
    func deleteCard(at offsets: IndexSet) {
        flashcardSet.cards.remove(atOffsets: offsets)
        
        if index >= flashcardSet.cards.count {
            index = max(0, flashcardSet.cards.count - 1)
        }
    }
    
    var body: some View {
        VStack {
            if !flashcardSet.cards.isEmpty {
                let card = flashcardSet.cards[index]
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                        .shadow(radius: 4)
                    
                    Text(showingAnswer ? card.answer : card.question)
                        .font(.title)
                        .padding()
                }
                .frame(height: 200)
                .onTapGesture {
                    withAnimation {
                        showingAnswer.toggle()
                    }
                }
            }
        }
        .navigationTitle(flashcardSet.title)
    }
}

