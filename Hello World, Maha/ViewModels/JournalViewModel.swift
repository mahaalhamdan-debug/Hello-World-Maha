import Foundation
import Observation
import SwiftData

// خيارات الترتيب
enum SortOption {
    case bookmark
    case date
}

@Observable
class JournalViewModel {
    var journals: [Journal] = []
    var searchText = ""
    var sortOption: SortOption = .date

    private var modelContext: ModelContext?

    // نستلم الدفتر، ونقرا اليوميات المحفوظة
    func setup(modelContext: ModelContext) {
        self.modelContext = modelContext
        let descriptor = FetchDescriptor<Journal>()
        journals = (try? modelContext.fetch(descriptor)) ?? []
    }

    // نثبّت التغييرات في الدفتر
    private func save() {
        try? modelContext?.save()
    }

    // القائمة المرتبة
    var sortedJournals: [Journal] {
        switch sortOption {
        case .bookmark:
            return journals.sorted { first, second in
                first.isBookmarked && !second.isBookmarked
            }
        case .date:
            return journals.sorted { first, second in
                first.date > second.date
            }
        }
    }

    // القائمة اللي تنعرض: مرتبة ومفلترة حسب البحث
    var displayedJournals: [Journal] {
        if searchText.isEmpty {
            return sortedJournals
        }
        return sortedJournals.filter { journal in
            journal.title.localizedStandardContains(searchText) ||
            journal.content.localizedStandardContains(searchText)
        }
    }

    // إضافة يومية جديدة
    func addJournal(title: String, content: String) {
        let newJournal = Journal(
            title: title,
            content: content,
            date: Date(),
            isBookmarked: false
        )
        modelContext?.insert(newJournal)
        journals.insert(newJournal, at: 0)
        save()
    }

    // حذف يومية
    func deleteJournal(journal: Journal) {
        modelContext?.delete(journal)
        journals.removeAll { item in
            item.id == journal.id
        }
        save()
    }

    // تعبئة أو تفضية الـ Bookmark
    func toggleBookmark(journal: Journal) {
        if let index = journals.firstIndex(where: { item in item.id == journal.id }) {
            journals[index].isBookmarked.toggle()
        }
        save()
    }

    // تعديل عنوان ونص يومية
    func updateJournal(journal: Journal, title: String, content: String) {
        if let index = journals.firstIndex(where: { item in item.id == journal.id }) {
            journals[index].title = title
            journals[index].content = content
        }
        save()
    }
}
