//
//  AddSetView.swift
//  Flashcards
//
//  Created by Big Guy on 11/19/25.
//

import SwiftUI

struct AddSetView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""

    var onSave: (String) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Set Title") {
                    TextField("Ex: Spanish", text: $title)
                }
            }
            .navigationTitle("New Set")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(title)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}
