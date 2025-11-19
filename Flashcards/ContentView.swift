//
//  ContentView.swift
//  Flashcards
//
//  Created by Big Guy on 11/18/25.
//

import SwiftUI

// Models
struct Flashcard: Identifiable {
    var id: UUID
    var question: String
    var answer: String
}

struct FlashcardSet: Identifiable {
    var id: UUID
    var title: String
    var cards: [Flashcard]
}

struct ContentView: View {
    
    @State private var sets: [FlashcardSet] = [
        FlashcardSet(
            id: UUID(),
            title: "Spanish",
            cards: [
                Flashcard(id: UUID(), question: "Hola", answer: "Hello"),
                Flashcard(id: UUID(), question: "Queso", answer: "Cheese")
            ]
        ),
        FlashcardSet(
            id: UUID(),
            title: "French",
            cards: [
                Flashcard(id: UUID(), question: "Bonjour", answer: "Hello")
            ]
        ),
        FlashcardSet(
            id: UUID(),
            title: "Math",
            cards: []
        )
    ]
    
    // Delete Function
    func deleteSet(at offsets: IndexSet) {
        sets.remove(atOffsets: offsets)
    }
    
    // Body
    var body: some View {
        NavigationStack {
            List {
                ForEach($sets) { $set in
                    NavigationLink {
                        FlashcardSetView(flashcardSet: $set)
                    } label: {
                        Text(set.title)
                    }
                }
                .onDelete(perform: deleteSet) 
            }
            .navigationTitle("Flashcard Sets")
        }
    }
}

#Preview {
    ContentView()
}
