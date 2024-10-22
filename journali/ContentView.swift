//
//  ContentView.swift
//  journali
//
//  Created by Ranad aldawood on 17/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.splash, location: 0.2),
                    .init(color: Color.black, location: 0.8)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Image("url")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 77.7, height: 101.0)
                    .padding(.bottom, 5)

                Text("Journali")
                    .foregroundColor(Color.white)
                    .font(.system(size: 42, weight: .black))
                    .padding(.bottom, 1)

                Text("MAIN")
                    .foregroundColor(Color.white)
                    .font(.system(size: 18, weight: .light))
                    .padding(.top, 1)
                    .kerning(1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
