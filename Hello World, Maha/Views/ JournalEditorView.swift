//
//   JournalEditorView.swift
//  Hello World, Maha
//
//  Created by Maha Alhamdan on 06/06/1448 AH.
//

import SwiftUI

// خانات الكتابة في الصفحة
enum EditorField {
    case title
    case content
}

struct JournalEditorView: View {
    let viewModel: JournalViewModel
    var journalToEdit: Journal? = nil
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var content = ""
    @State private var showDiscardAlert = false
    @FocusState private var focusedField: EditorField?
    
    // هل المستخدم غيّر شي؟
    var hasChanges: Bool {
        if let journal = journalToEdit {
            return title != journal.title || content != journal.content
        } else {
            return !title.isEmpty || !content.isEmpty
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                // العنوان
                TextField("Title", text: $title)
                    .font(.headingL)
                    .foregroundStyle(Color.textPrimary)
                    .focused($focusedField, equals: .title)
                    .submitLabel(.next)
                                        .onSubmit {
                                            focusedField = .content
                                        }
                
                // التاريخ
                Text((journalToEdit?.date ?? Date()).formatted(date: .numeric, time: .omitted))
                    .font(.captionM)
                    .foregroundStyle(Color.textSecondary)
                
                // نص اليومية
                TextField("Type your Journal...", text: $content, axis: .vertical)
                    .font(.bodyL)
                    .foregroundStyle(Color.textPrimary)
                    .padding(.top, 16)
                    .focused($focusedField, equals: .content)
                
                // المساحة الفاضية: الضغط عليها يودي للنص
                                Color.clear
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        focusedField = .content
                                    }
            }
            .padding(.horizontal, 20)
            .onAppear {
                if let journal = journalToEdit {
                    title = journal.title
                    content = journal.content
                    focusedField = .content
                } else {
                    focusedField = .title
                }
            }
            .toolbar {
                // زر الإغلاق ✕
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        if hasChanges {
                            showDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    }
                    .confirmationDialog(
                        "Are you sure you want to discard changes on this journal?",
                        isPresented: $showDiscardAlert,
                        titleVisibility: .visible
                    ) {
                        Button("Discard Changes", role: .destructive) {
                            dismiss()
                        }
                        Button("Keep Editing") { }
                    }
                }
                
                // زر الحفظ ✓
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", systemImage: "checkmark") {
                        if let journal = journalToEdit {
                            viewModel.updateJournal(journal: journal, title: title, content: content)
                        } else {
                            viewModel.addJournal(title: title, content: content)
                        }
                        dismiss()
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color.primaryAccent)
                    .disabled(title.isEmpty)
                }
            }
        }
        .presentationBackground(Color.surfaceCard)
        .interactiveDismissDisabled(hasChanges)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    JournalEditorView(viewModel: JournalViewModel())
}
