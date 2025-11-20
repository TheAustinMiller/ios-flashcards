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
    @State private var isAddingNewSet: Bool = false
    @State private var newTitle: String = ""
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
    
    func addSet() {
        let trimmed = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        sets.append(FlashcardSet(id: UUID(), title: trimmed, cards: []))
        newTitle = ""
        isAddingNewSet = false
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
                
                if isAddingNewSet {
                    HStack {
                        Button {
                            isAddingNewSet = false
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        
                        TextField("New set", text: $newTitle)
                            .textFieldStyle(.plain)
                        
                        Button {
                            addSet()
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                } else {
                    Button {
                        isAddingNewSet = true
                    } label: {
                        HStack {
                            Spacer()
                            Image(systemName: "plus")
                                .foregroundColor(.green)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Flashcards!")
        }
    }
}

#Preview {
    ContentView()
}
