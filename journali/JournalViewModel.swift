import SwiftUI
import Combine

class JournalViewModel: ObservableObject {
    @Published var journalEntries: [JournalEntry] = []
    @Published var searchText: String = ""
    @Published var showBookmarksOnly = false
    @Published var isSortedDescending = true

    // Filtering, sorting, and updating the list of entries
    var filteredEntries: [JournalEntry] {
        journalEntries
            .filter { entry in
                (searchText.isEmpty || entry.title.localizedCaseInsensitiveContains(searchText) || entry.content.localizedCaseInsensitiveContains(searchText)) &&
                (!showBookmarksOnly || entry.isBookmarked)
            }
            .sorted {
                isSortedDescending ? $0.date > $1.date : $0.date < $1.date
            }
    }

    func addEntry(title: String, content: String) {
        let newEntry = JournalEntry(title: title, content: content, date: Date())
        journalEntries.append(newEntry)
    }

    func updateEntry(entry: JournalEntry, title: String, content: String) {
        if let index = journalEntries.firstIndex(where: { $0.id == entry.id }) {
            journalEntries[index].title = title
            journalEntries[index].content = content
        }
    }

    func deleteEntry(_ entry: JournalEntry) {
        journalEntries.removeAll { $0.id == entry.id }
    }

    func toggleBookmark(for entry: JournalEntry) {
        if let index = journalEntries.firstIndex(where: { $0.id == entry.id }) {
            journalEntries[index].isBookmarked.toggle()
        }
    }

    func sortByJournalDate() {
        isSortedDescending.toggle()
    }
}
