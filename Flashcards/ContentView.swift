//
//  ContentView.swift
//  Flashcards
//
//  Created by Big Guy on 11/18/25.
//

import SwiftUI

// Models
struct Flashcard: Identifiable, Codable, Equatable {
    var id: UUID
    var question: String
    var answer: String
}

struct FlashcardSet: Identifiable, Codable, Equatable {
    var id: UUID
    var title: String
    var cards: [Flashcard]
}

struct ContentView: View {
    @State private var showingAddSet = false
    @State private var sets: [FlashcardSet] = [
        FlashcardSet(
            id: UUID(),
            title: "Spanish",
            cards: [
                Flashcard(id: UUID(), question: "Hola", answer: "Hello"),
                Flashcard(id: UUID(), question: "Queso", answer: "Cheese"),
                Flashcard(id: UUID(), question: "Aqui, Aye Carumba", answer: "Here, damn")
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
    
    let setsKey = "flashcard_sets"

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: setsKey) {
            if let decoded = try? JSONDecoder().decode([FlashcardSet].self, from: data) {
                sets = decoded
            }
        }
    }

    func saveData() {
        if let encoded = try? JSONEncoder().encode(sets) {
            UserDefaults.standard.set(encoded, forKey: setsKey)
        }
    }
    
    func deleteSet(at offsets: IndexSet) {
        sets.remove(atOffsets: offsets)
    }

    func addSet(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        sets.append(
            FlashcardSet(id: UUID(), title: trimmed, cards: [])
        )
    }
    
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
            .navigationTitle("Flashcards!")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddSet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSet) {
                AddSetView { newTitle in
                    addSet(title: newTitle)
                }
            }
        }
        .onAppear(perform: loadData)
        .onChange(of: sets) { oldValue, newValue in
            saveData()
        }
    }
}

#Preview {
    ContentView()
}
