import SwiftUI

struct ContentView: View {
    @State private var showAddJournalSheet = false
    @State private var journalEntries: [JournalEntry] = []
    @State private var selectedEntry: JournalEntry? = nil

    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color.black.ignoresSafeArea() // Black background

                VStack(alignment: .leading) {
                    // Custom header with Journal title and toolbar buttons
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
                    Spacer().frame(height: 20)

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
                            ForEach(journalEntries) { entry in
                                VStack(alignment: .leading) {
                                    Text(entry.title)
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundColor(.lilac)
                                    
                                    Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Text(entry.content)
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                        .lineLimit(2)
                                        .padding(.top, 10)
                                        .frame(width: 320)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
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
                            .listRowBackground(Color.black) // Ensure list rows match background color
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
