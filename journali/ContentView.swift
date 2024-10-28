import SwiftUI

struct ContentView: View {
    @State private var showAddJournalSheet = false
    @State private var journalEntries: [JournalEntry] = []
    @State private var selectedEntry: JournalEntry? = nil
    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color.black.ignoresSafeArea() // Black background
                
                VStack(alignment: .leading, spacing: 0) {
                    // Custom title and toolbar
                    HStack {
                        Text("Journal")
                            .foregroundColor(.white)
                            .font(.system(size: 34, weight: .semibold))
                            .padding(.leading, 20)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        // Filter Button
                        Menu {
                            Button("Bookmark", action: bookmark)
                            Button("Journal Date", action: sortByJournalDate)
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
                    
                    // Search bar below the title and toolbar
                    TextField("Search", text: $searchText)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.white) // Ensures the text inside search bar is white
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)

                    Spacer().frame(height: 20)

                    let filteredEntries = journalEntries.filter {
                        searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText) || $0.content.localizedCaseInsensitiveContains(searchText)
                    }
                    
                    if journalEntries.isEmpty {
                        // Centered empty state with image, label, and description text
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
                        // Display journal entries with swipe actions in a List
                        List {
                            ForEach(filteredEntries) { entry in
                                ZStack(alignment: .topLeading) {
                                    VStack(alignment: .leading, spacing: 5) {
                                        HStack {
                                            Text(entry.title)
                                                .font(.system(size: 24, weight: .semibold))
                                                .foregroundColor(.lilac)
                                            
                                            Spacer() // Pushes the bookmark button to the far right
                                            
                                            Button(action: {}) {
                                                Image(systemName: "bookmark")
                                                    .foregroundColor(.lilac)
                                            }
                                            .padding(.trailing, 10) // Adjusts the right padding as needed
                                        }
                                        
                                        Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .padding(.bottom, 5)
                                        
                                        Text(entry.content)
                                            .font(.system(size: 18))
                                            .foregroundColor(.white)
                                            .lineLimit(2)
                                            .frame(width: 350, alignment: .leading)
                                            .padding(.top, 10)
                                    }
                                    .padding() // Adds padding around the entire VStack
                                }
                                .padding()
                                
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
                            .listRowBackground(Color.gray.opacity(0.2)) // Ensure list rows match background color
                        }
                        .scrollContentBackground(.hidden) // Hide default List background
                        .padding(.horizontal, -20) // Adjust padding to match the previous layout
                    }
                }
            }
            .sheet(isPresented: $showAddJournalSheet) {
                AddNewJournal(
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

    private func bookmark() {
        print("Bookmark action")
    }

    private func sortByJournalDate() {
        print("Sort by journal date action")
    }
}

#Preview {
    ContentView()
}
