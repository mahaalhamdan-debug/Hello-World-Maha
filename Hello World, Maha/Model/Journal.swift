import Foundation
import SwiftData

@Model
class Journal {
    var title: String
    var content: String
    var date: Date
    var isBookmarked: Bool

    init(title: String, content: String, date: Date, isBookmarked: Bool) {
        self.title = title
        self.content = content
        self.date = date
        self.isBookmarked = isBookmarked
    }
}

// بيانات تجريبية للـ Preview
extension Journal {
    static let samples: [Journal] = [
        Journal(
            title: "First Day in the Academy",
            content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis.",
            date: Date(),
            isBookmarked: true
        ),
        Journal(
            title: "Today's Journal",
            content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros.",
            date: Date(),
            isBookmarked: false
        ),
        Journal(
            title: "First Project",
            content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio.",
            date: Date(),
            isBookmarked: false
        )
    ]
}
