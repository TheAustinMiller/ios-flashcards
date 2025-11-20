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
    @State private var dragAmount: CGFloat = 0
    @State private var showingAddCard = false

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
                .offset(x: dragAmount)   // <-- card visually moves
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragAmount = value.translation.width
                        }
                        .onEnded { value in
                            let threshold: CGFloat = 100
                            
                            // Swipe left → next card
                            if value.translation.width < -threshold {
                                if index < flashcardSet.cards.count - 1 {
                                    withAnimation {
                                        index += 1
                                        showingAnswer = false
                                    }
                                }
                            }
                            
                            // Swipe right → previous card
                            else if value.translation.width > threshold {
                                if index > 0 {
                                    withAnimation {
                                        index -= 1
                                        showingAnswer = false
                                    }
                                }
                            }
                            
                            // Reset card position
                            withAnimation {
                                dragAmount = 0
                            }
                        }
                )
                .onTapGesture {
                    withAnimation {
                        showingAnswer.toggle()
                    }
                }
            }
        }
        .navigationTitle(flashcardSet.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddCard = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddCard) {
            AddFlashcardView(setTitle: flashcardSet.title) { question, answer in
                addCard(question: question, answer: answer)
            }
        }

        if flashcardSet.cards.count > 0 {
            Text("\(index + 1)/\(flashcardSet.cards.count)")
        } else {
            Text("Create a flashcard to start")
        }
        
    }
}
