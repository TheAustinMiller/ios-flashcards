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
    var onDelete: () -> Void

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
                ToolbarItem(placement: .bottomBar) {
                    Button(role: .destructive) {
                        onDelete()
                        dismiss()
                    } label: {
                        Text("Delete")
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
