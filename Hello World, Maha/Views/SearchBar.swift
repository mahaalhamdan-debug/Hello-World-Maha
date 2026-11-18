//
//  SearchBar.swift
//  Hello World, Maha
//
//  Created by Maha Alhamdan on 08/06/1448 AH.
//
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var speech = SpeechRecognizer()

    var body: some View {
        HStack(spacing: 8) {
            // أيقونة البحث
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.textSecondary)

            // خانة الكتابة
            TextField("Search", text: $text)
                .foregroundStyle(Color.textPrimary)

            // زر المايك
            Button {
                if speech.isRecording {
                    speech.stop()
                } else {
                    Task {
                        if await speech.requestPermission() {
                            speech.start()
                        }
                    }
                }
            } label: {
                Image(systemName: speech.isRecording ? "mic.fill" : "mic")
                    .foregroundStyle(speech.isRecording ? Color.primaryAccent : Color.textSecondary)
            }
        }
        .font(.bodyM)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .glassEffect()
        // الكلام المسموع يروح للبحث
        .onChange(of: speech.transcript) {
            text = speech.transcript
        }
    }
}

#Preview {
    SearchBar(text: .constant(""))
        .padding()
        .preferredColorScheme(.dark)
}
