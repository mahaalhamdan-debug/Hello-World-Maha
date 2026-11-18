//
//  JournalCard.swift
//  Hello World, Maha
//
//  Created by Maha Alhamdan on 02/06/1448 AH.
//

import SwiftUI

struct JournalCard: View {
    let journal: Journal
    let viewModel: JournalViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // السطر الأول: العنوان والـ Bookmark
            HStack {
                Text(journal.title)
                    .font(.titleCard)
                    .foregroundStyle(Color.textAccent)

                Spacer()

                Button {
                                    viewModel.toggleBookmark(journal: journal)
                                } label: {
                                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                                        .font(.title2)
                                        .foregroundStyle(Color.textAccent)
                                }
                                .buttonStyle(.plain)
            }

            // التاريخ
            Text(journal.date.formatted(date: .numeric, time: .omitted))
                .font(.captionS)
                .foregroundStyle(Color.textSecondary)

            // نص اليومية
            Text(journal.content)
                .font(.bodyM)
                .foregroundStyle(Color.textPrimary)
                .lineLimit(5)
                .padding(.top, 8)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.surfaceCard)
        .clipShape(RoundedRectangle(cornerRadius: 32))
    }
}

#Preview {
    JournalCard(journal: Journal.samples[0], viewModel: JournalViewModel())
        .padding()
        .preferredColorScheme(.dark)
}
