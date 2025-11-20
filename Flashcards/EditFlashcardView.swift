//
//  EditFlashcardView.swift
//  Flashcards
//
//  Created by Big Guy on 11/20/25.
//

import SwiftUI

struct EditFlashcardView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var card: Flashcard
    @State private var question: String = ""
    @State private var answer: String = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Question", text: $question)
                TextField("Answer", text: $answer)
            }
            .navigationTitle("Edit Card")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        card.question = question
                        card.answer = answer
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            question = card.question
            answer = card.answer
        }
    }
}
