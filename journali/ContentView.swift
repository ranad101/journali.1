//
//  ContentView.swift
//  journali
//
//  Created by Ranad aldawood on 17/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet = false
    var body: some View {
        ZStack(alignment: .topLeading) { // ZStack for layering views
            // Background content
            NavigationStack {
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
                    .background(Color.black)
                    .ignoresSafeArea()
            }

            // Top-left "Journal" text
            Text("Journal")
                .foregroundColor(.white)
                .font(.system(size: 34, weight: .semibold))
                .padding(.top, 50)  // Padding from the top of the screen
                .padding(.leading, 20)  // Padding from the left edge

            // Buttons for filtering and adding a journal
            HStack {
                Button(action: {
                    // Action for filter button
                    print("Filter journals")
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle.fill") // Filter icon
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.lilac)
                }

                Button(action: { showSheet.toggle()
                    // Action for adding a new journal
                    print("Add new journal")
                }) {
                    Image(systemName: "plus.circle.fill") // Plus icon
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.lilac)
                }
            } .sheet(isPresented: $showSheet, content:{ Rectangle() .fill(Color.black)})
            
            .padding(.top, 50)  // Padding from the top
            .padding(.trailing, 20)  // Padding from the right
            .frame(maxWidth: .infinity, alignment: .topTrailing) // Align buttons to the top-right
        }
    }
}

#Preview {
    ContentView()
}
