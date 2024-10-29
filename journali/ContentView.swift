import SwiftUI

struct ContentView: View {
    @State private var showAddJournalSheet = false
    @State private var journalEntries: [JournalEntry] = []
    @State private var selectedEntry: JournalEntry? = nil
    @State private var searchText: String = ""
    @State private var showBookmarksOnly = false
    @State private var isSortedDescending = true

    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color.black.ignoresSafeArea() // Black background
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Journal")
                            .foregroundColor(.white)
                            .font(.system(size: 34, weight: .semibold))
                            .padding(.leading, 20)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        // Filter and Sort Menu
                        Menu {
                            Button("Show Bookmarks") {
                                showBookmarksOnly.toggle()
                            }
                            Button("Sort by Journal Date") {
                                sortByJournalDate()
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .foregroundColor(.lilac)
                        }
                        .padding(.top, 20)

                        // Add Button
                        Button(action: {
                            selectedEntry = nil
                            showAddJournalSheet = true
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.lilac)
                        }
                        .padding(.trailing, 20)
                        .padding(.top, 20)
                    }
                    
                    // Search bar with left and right icons
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchText)
                            .foregroundColor(.white)
                        Image(systemName: "mic.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                    Spacer().frame(height: 20)

                    let filteredEntries = journalEntries
                        .filter { entry in
                            (searchText.isEmpty || entry.title.localizedCaseInsensitiveContains(searchText) || entry.content.localizedCaseInsensitiveContains(searchText)) &&
                            (!showBookmarksOnly || entry.isBookmarked)
                        }
                        .sorted {
                            isSortedDescending ? $0.date > $1.date : $0.date < $1.date
                        }
                    
                    if journalEntries.isEmpty {
                        VStack(spacing: 10) {
                            Image("url")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                            
                            Text("Begin Your Journal")
                                .foregroundColor(.lilac)
                                .font(.system(size: 24, weight: .bold))
                            
                            Text("Craft your personal diary, tap the plus icon to begin")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .light))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        // Display journal entries
                        List {
                            ForEach(filteredEntries) { entry in
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 350, height: 227)
                                        .cornerRadius(10)
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        // Title and Bookmark raised slightly
                                        HStack {
                                            Text(entry.title)
                                                .font(.system(size: 24, weight: .semibold))
                                                .foregroundColor(.lilac)
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                toggleBookmark(for: entry)
                                            }) {
                                                Image(systemName: entry.isBookmarked ? "bookmark.fill" : "bookmark")
                                                    .foregroundColor(.lilac)
                                            }
                                        }
                                        .padding(.top, -30) // Adjust for raised look
                                        
                                        // Date and Content
                                        Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        
                                        Text(entry.content)
                                            .font(.system(size: 18))
                                            .foregroundColor(.white)
                                            .lineLimit(5)
                                            .frame(width: 320)
                                            .padding(.top, 10)
                                    }
                                    .padding()
                                }
                                .frame(width: 350, height: 227)
                                .cornerRadius(10)
                                .padding(.trailing, 20)
                                .padding(.top, 20)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        deleteEntry(entry)
                                    } label: {
                                        Label("", systemImage: "trash")
                                    }
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
                                        selectedEntry = entry
                                        showAddJournalSheet = true
                                    } label: {
                                        Label("", systemImage: "pencil")
                                    }
                                    .tint(.edit)
                                }
                            }
                            .listRowBackground(Color.black)
                        }
                        .scrollContentBackground(.hidden)
                        .padding(.horizontal, -20)
                    }
                }
            }
            .sheet(isPresented: $showAddJournalSheet) {
                AddNewJournal(
                    title: selectedEntry?.title ?? "",
                    content: selectedEntry?.content ?? "",
                    onSave: { title, content in
                        if let entryIndex = journalEntries.firstIndex(where: { $0.id == selectedEntry?.id }) {
                            journalEntries[entryIndex].title = title
                            journalEntries[entryIndex].content = content
                        } else {
                            let newEntry = JournalEntry(title: title, content: content, date: Date())
                            journalEntries.append(newEntry)
                        }
                        showAddJournalSheet = false
                    },
                    onCancel: {
                        showAddJournalSheet = false
                    }
                )
            }
        }
    }

    struct JournalEntry: Identifiable {
        var id = UUID()
        var title: String
        var content: String
        var date: Date
        var isBookmarked: Bool = false
    }

    private func deleteEntry(_ entry: JournalEntry) {
        if let index = journalEntries.firstIndex(where: { $0.id == entry.id }) {
            journalEntries.remove(at: index)
        }
    }

    private func toggleBookmark(for entry: JournalEntry) {
        if let index = journalEntries.firstIndex(where: { $0.id == entry.id }) {
            journalEntries[index].isBookmarked.toggle()
        }
    }

    private func sortByJournalDate() {
        isSortedDescending.toggle()
    }
}

#Preview {
    ContentView()
}
