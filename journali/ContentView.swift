import SwiftUI
struct ContentView: View {
    @StateObject private var viewModel = JournalViewModel()
    @State private var showAddJournalSheet = false
    @State private var selectedEntry: JournalEntry? = nil

    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color.black.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    headerView
                    searchBar
                    Spacer().frame(height: 20)

                    if viewModel.journalEntries.isEmpty {
                        emptyStateView
                    } else {
                        List {
                            ForEach(viewModel.filteredEntries) { entry in
                                entryRow(entry)
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
                        if let entry = selectedEntry {
                            viewModel.updateEntry(entry: entry, title: title, content: content)
                        } else {
                            viewModel.addEntry(title: title, content: content)
                        }
                        showAddJournalSheet = false
                    },
                    onCancel: { showAddJournalSheet = false }
                )
            }
        }
    }

    private var headerView: some View {
        HStack {
            Text("Journal")
                .foregroundColor(.white)
                .font(.system(size: 34, weight: .semibold))
                .padding(.leading, 20)
                .padding(.top, 20)
            Spacer()
            Menu {
                Button("Show Bookmarks") {
                    viewModel.showBookmarksOnly.toggle()
                }
                Button("Sort by Journal Date") {
                    viewModel.sortByJournalDate()
                }
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .foregroundColor(.lilac)
            }
            .padding(.top, 20)
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
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.gray)
            TextField("Search", text: $viewModel.searchText).foregroundColor(.white)
            Image(systemName: "mic.fill").foregroundColor(.gray)
        }
        .padding(10)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }

    private var emptyStateView: some View {
        VStack(spacing: 10) {
            Image("url").resizable().scaledToFit().frame(width: 80, height: 80)
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
    }

    private func entryRow(_ entry: JournalEntry) -> some View {
        ZStack(alignment: .leading) {
            Rectangle().fill(Color.gray.opacity(0.2)).frame(width: 350, height: 227).cornerRadius(10)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(entry.title).font(.system(size: 24, weight: .semibold)).foregroundColor(.lilac)
                    Spacer()
                    Button(action: { viewModel.toggleBookmark(for: entry) }) {
                        Image(systemName: entry.isBookmarked ? "bookmark.fill" : "bookmark")
                            .foregroundColor(.lilac)
                    }
                }.padding(.top, -30)
                Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption).foregroundColor(.gray)
                Text(entry.content)
                    .font(.system(size: 18)).foregroundColor(.white)
                    .lineLimit(5).frame(width: 320).padding(.top, 10)
            }
            .padding()
        }
        .frame(width: 350, height: 227)
        .cornerRadius(10)
        .padding(.trailing, 20)
        .padding(.top, 20)
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) { viewModel.deleteEntry(entry) } label: {
                Label("", systemImage: "trash")
            }
        }
        .swipeActions(edge: .leading) {
            Button { selectedEntry = entry; showAddJournalSheet = true } label: {
                Label("", systemImage: "pencil")
            }.tint(.edit)
        }
    }
}

#Preview {
    ContentView()
}
