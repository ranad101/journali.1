//
//  ContentView.swift
//  journali
//
//  Created by Ranad aldawood on 17/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet = false
    @State private var journalEntries: [JournalEntry] = [] // List to hold journal entries

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                // Background color
                Color.black
                    .ignoresSafeArea()

                // Conditional content based on whether journal entries exist
                if journalEntries.isEmpty {
                    // Show "Begin Your Journal" prompt if no entries exist
                    VStack {
                        ContentUnavailableView(
                            label: {
                            Label("Begin Your Journal", image: "url")
                                    .foregroundColor(.lilac)
                                    .font(.system(size: 24, weight: .bold))
                            },
                            description: {
                                Text("Craft your personal diary, tap the plus icon to begin")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .light))
                                    .padding(.top, 1)
                                    .kerning(0.6)
                            })
                            .padding(.top, 20)
                            .padding(.horizontal, 20)
                    }
                } else {
                    // Display list of journal entries if they exist
                    ScrollView {
                        ForEach(journalEntries) { entry in
                            VStack(alignment: .leading) {
                                Text(entry.title)
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.lilac)
                                    
                                Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                                    .font(.caption)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.gray)
                                
                                
                                Text(entry.content)
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .lineLimit(2) // Limit content to the first 2 lines
                                    .frame(width: 350)
                                    .padding(.top , 10)
                               
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2)) // Slight background for each entry
                            .cornerRadius(10)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            
                        }
                    }
                    .padding(.top, 100) // Ensure content starts below the header
                }

                // Top-left "Journal" text
                Text("Journal")
                    .foregroundColor(.white)
                    .font(.system(size: 34, weight: .semibold))
                    .padding(.top, 50)
                    .padding(.leading, 20)

                // Buttons for filtering and adding a journal
                HStack {
                    Button(action: {
                        // Action for filter button
                        print("Filter journals")
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.lilac)
                    }

                    Button(action: { showSheet.toggle()
                        // Action for adding a new journal
                        print("Add new journal")
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.lilac)
                    }
                }
                .padding(.top, 50)
                .padding(.trailing, 20)
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .sheet(isPresented: $showSheet) {
                    AddNewJournal(
                        onSave: { title, content in
                            let newEntry = JournalEntry(title: title, content: content, date: Date())
                            journalEntries.append(newEntry) // Add new entry to the list
                            showSheet = false // Dismiss the sheet
                        },
                        onCancel: {
                            showSheet = false // Just dismiss the sheet
                        }
                    )
                }
            }
        }
    }

    // Local definition of JournalEntry inside ContentView to avoid ambiguity
    struct JournalEntry: Identifiable {
        var id = UUID()
        var title: String
        var content: String
        var date: Date
    }
}

#Preview {
    ContentView()
}
