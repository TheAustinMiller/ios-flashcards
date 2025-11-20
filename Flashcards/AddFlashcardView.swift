//
//  AddFlashcardView.swift
//  Flashcards
//
//  Created by Big Guy on 11/19/25.
//

import SwiftUI

struct AddFlashcardView: View {
    @Environment(\.dismiss) var dismiss
    @State private var question = ""
    @State private var answer = ""
    
    let setTitle: String
    var onSave: (String, String) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Question")) {
                    TextField("Enter question", text: $question)
                }

                Section(header: Text("Answer")) {
                    TextField("Enter answer", text: $answer)
                }
            }
            .navigationTitle("New \(setTitle) card")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(question, answer)
                        dismiss()
                    }
                    .disabled(question.isEmpty || answer.isEmpty)
                }
            }
        }
    }
}
